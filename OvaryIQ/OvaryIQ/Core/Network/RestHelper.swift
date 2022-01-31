//
//  RestHelper\.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

//
//  RestHelper.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import Alamofire

let success = 1
let failure = 0

enum RequestState: Int {
    case NONE       =   0
    case WAITING
    case PROCESSING
    case COMPLETED
}

enum RequestPriority: Int {
    case DEFAULT       =   0
    case HIGH
}

class RestHelper: NSObject {

    static let shared = RestHelper()

    let scheduler = RequestScheduler.shared

    let onRestCompletionBlock = {(what: Int, result: Int, response: Any) -> Void in
        var restEvent = RestEngineEvents.init(id: RestEvents(rawValue: what)!, obj: response)
        restEvent.state = RequestState.COMPLETED
        CoreEngine.shared.addEvent(evObj: restEvent)
    }

    let progressBlock = {(_ what: Int, _ progress: Double,_ url: URL) -> Void in

        let progressData = ["kDalProgress": progress,"kDalFilePath": url] as [String: Any]

        var restEvent = RestEngineEvents.init(id: RestEvents(rawValue: what)!, obj: progressData as Any)
        restEvent.state = .PROCESSING
        CoreEngine.shared.addEvent(evObj: restEvent)
    }

    public func processRestRequest(evObj: RestEngineEvents) {

        fLog()

        let restEventId = RestEvents(rawValue: evObj.eventID)!

        switch restEventId {
           case .SignUp:
            if let parameters = evObj.object as? [String:Any] {
                evObj.apiRequest =  APIRouter.signUp(params: parameters)
            }else{
                dLog(message: "Parameter Missing :: \(APIName.SignUp)")
            }

           case .networkError:
            break

        }

        self.addRequestInScheduler(requestObj: evObj)
    }

    private func addRequestInScheduler(requestObj: RestEngineEvents) {
        var request = requestObj
        self.scheduler.addReqInQueue(reqObj: &request, completionBlock: onRestCompletionBlock , progressBlock: progressBlock)
    }

    private func addBasicParameters() {

    }

    public func clearRestEvents() {
        self.scheduler.clearAllRestEvent()
    }

    public func clearRestEvent(_ id: RestEvents) {
        self.scheduler.clearCacheForRestEvent(restEvent: id)
    }
}

