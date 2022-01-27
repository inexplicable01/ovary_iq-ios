//
//  EventLoop.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
class EventLoop: Thread {

    override func main() {
        let runloop = RunLoop.current
        runloop.add(NSMachPort(), forMode: .default)
        runloop.run()
    }

    func addEvent(evObj: EngineEvents) {
        self.perform(#selector(processQueuedEvent(evobj:)), on: self, with: evObj, waitUntilDone: false)
    }

    @objc func processQueuedEvent(evobj: Any) {
        dLog(message: "Rest Event Processed at :: \(Date())")
    }

    func cancelEvent() {
        RunLoop.cancelPreviousPerformRequests(withTarget: self)
    }
}
