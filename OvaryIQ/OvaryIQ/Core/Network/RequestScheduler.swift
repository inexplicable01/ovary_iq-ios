//
//  RequestScheduler.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
import UIKit

let kThreadSleepTime = 1000
let kSlowQueue = "slowQueue"
let kFastQueue = "fastQueue"
let kRequestSchThread = "requestSchThread"

class RequestScheduler: NSObject {

    // -- Request scheduler lock
    // -- Always remember free the lock
    var queueMutex: NSLock

    // -- Thread sync semaphore
    var sema: DispatchSemaphore

    // -- Request scheduler event queue
    var fastQueueCache: [RestEngineEvents]
    var slowQueueCache: [RestEngineEvents]

    // -- Request scheduler thread
    var schThread: Thread
    var needToNotify: Bool

    // -- Network request queues
    var slowQueue: NetworkManager?
    var fastQueue: NetworkManager?

    static let shared = RequestScheduler()

    override init() {

        self.queueMutex = NSLock()

        self.slowQueue = NetworkManager()
        self.slowQueue?.queueType = kSlowQueue

        self.fastQueue = NetworkManager()
        self.fastQueue?.queueType = kFastQueue

        self.slowQueueCache = [RestEngineEvents]()
        self.fastQueueCache = [RestEngineEvents]()

        self.sema = DispatchSemaphore.init(value: 0)

        self.needToNotify = true

        self.schThread = Thread.init()

        super.init()

        self.schThread = Thread.init(target: self, selector: #selector(reqScheduleHndl), object: nil)
        self.schThread.name = kRequestSchThread
        self.schThread.start()
    }

    func addReqInQueue(reqObj: inout RestEngineEvents, completionBlock: @escaping (_ evType: Int, _ result: Int, _ response: Any) -> Void, progressBlock: @escaping (_ evType: Int, _ result: Double, _ url: URL) -> Void) {

        // -- Take lock to add request into queue
        queueMutex.lock()

        // update the state of Request Object
        // From None -> Waiting in Queue
        reqObj.state = .WAITING
        reqObj.completionBlock = completionBlock
        reqObj.progressBlock = progressBlock

        // -- Add request into cache to process
        if reqObj.fastQueue {
            if reqObj.priority == RequestPriority.HIGH {
                self.fastQueueCache.insert(reqObj, at: 0)
            } else {
                self.fastQueueCache.append(reqObj)
            }
        } else {
            self.slowQueueCache.append(reqObj)
        }

        // -- Release lock here
        self.queueMutex.unlock()
    }

    func clearAllRestEvent() {
        // -- Take lock to remove tag from queue
        self.queueMutex.lock()

        if !self.fastQueueCache.isEmpty {
            self.fastQueueCache.removeAll()
        }

        // -- Release lock here
        self.queueMutex.unlock()
    }


    func clearCacheForRestEvent(restEvent: RestEvents) {
        // -- Take lock to remove tag from queue
        self.queueMutex.lock()

        if !self.fastQueueCache.isEmpty {

            var tempQueue = [RestEngineEvents]()

            self.fastQueueCache.forEach { (object) in

                if object.eventID == restEvent.rawValue {
                    tempQueue.append(object)
                }
            }

            // Clear Request from Cache
            if !tempQueue.isEmpty {
                tempQueue.forEach { (object) in

                    let index = self.fastQueueCache.firstIndex(where: {$0.eventID == object.eventID})

                    if index != NSNotFound {
                        self.fastQueueCache.remove(at: index!)
                    }
                }
            }
        }

        // -- Release lock here
        self.queueMutex.unlock()
    }


    /*
     Thread handle to moniter event queue and schedule them
     into network queue.
     */
    @objc func reqScheduleHndl() {

        while true {

            // -- Check event queue and schedule request here
            self.queueMutex.lock()

            if !self.fastQueueCache.isEmpty || !self.slowQueueCache.isEmpty {

                // -- Get and remove object from event queue
                if let request = self.getNxtRequest() {

                    // update the state of Request Object
                    // From Waiting -> Processing in Queue
                    request.state = .PROCESSING

                    // -- Add event object into network run loop here
                    if request.fastQueue {
                        self.fastQueue?.addNetworkEvent(evobj: request)
                    } else {
                        self.slowQueue?.addNetworkEvent(evobj: request)
                    }

                    self.queueMutex.unlock()

                    // -- Pause scheduler thead with semaphore wait here
                    _ = self.sema.wait(timeout: .distantFuture)


                } else {
                    // Error no request found
                    self.queueMutex.unlock()
                }

            } else {
                self.queueMutex.unlock()
                usleep(useconds_t(kThreadSleepTime))
            }
        }

    }

    // -- Do not call this func with mutex lock
    func getNxtRequest() -> RestEngineEvents? {

        var evobj: RestEngineEvents? = nil

        if !self.fastQueueCache.isEmpty {
            evobj = self.fastQueueCache.first!
        } else if (!self.slowQueueCache.isEmpty && !(self.slowQueue?.isFileInProcess)!) {
            evobj = self.slowQueueCache.first!
        }

        return evobj
    }

    func notifyProgress(queueType: String, progress: Double, forFile url: URL) {

        //-- Remove processed request
        self.queueMutex.lock()

        if queueType == kSlowQueue, !self.slowQueueCache.isEmpty {

            if let evobj = self.slowQueueCache.first, evobj.state == RequestState.PROCESSING {

                // Call callback handler
                if let callback = evobj.progressBlock {
                    callback(evobj.eventID,progress,url)
                }

            } else {
                // Ignore waiting request
                DispatchQueue.main.async {
                    AlertControllerManager.showToast(message: ErrorMessages.timeout.localizedString, type: AlertType.error)
                }
            }

        }

        self.queueMutex.unlock()
    }

    func notifyThread(queueType: String, response: Any) {

        //-- Remove processed request
        self.queueMutex.lock()

        if queueType == kFastQueue, !self.fastQueueCache.isEmpty {
            // Remove request only if it was in processing state
            // otherwise it will endup removing wrong waiting request

            if let evobj = self.fastQueueCache.first, evobj.state == .PROCESSING {
                // Call callback handler
                if let callback = evobj.completionBlock{
                    callback(evobj.eventID, success, response)
                }

                self.fastQueueCache.removeFirst()

            } else {
                // Ignore waiting request
                DispatchQueue.main.async {
                   AlertControllerManager.showToast(message: ErrorMessages.timeout.localizedString, type: AlertType.error)
                }
            }

        } else if queueType == kSlowQueue, !self.slowQueueCache.isEmpty {

            if let evobj = self.slowQueueCache.first, evobj.state == .PROCESSING {

                // Call callback handler
                if let callback = evobj.completionBlock {
                    callback(evobj.eventID, success, response)
                }

                self.slowQueueCache.removeFirst()

            } else {
                // Ignore waiting request
                DispatchQueue.main.async {
                    AlertControllerManager.showToast(message: ErrorMessages.timeout.localizedString, type: AlertType.error)

                }
            }

        }

        self.queueMutex.unlock()

        // -- Resume thread semaphore here
        self.sema.signal()
    }
}
