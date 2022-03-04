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
             if let parameters = evObj.object as? [String: Any] {
                evObj.apiRequest =  APIRouter.signUp(params: parameters)
              }else{
                dLog(message: "Parameter Missing :: \(APIName.SignUp)")
              }

           case .login:
             if let parameters = evObj.object as? [String: Any] {
                evObj.apiRequest =  APIRouter.login(params: parameters)
              }else{
                dLog(message: "Parameter Missing :: \(APIName.Login)")
              }

           case .logout:
              if let parameters = evObj.object as? [String: Any] {
                evObj.apiRequest = APIRouter.logOut(params: parameters)
              } else {
                dLog(message: "Parameter Missing :: \(APIName.LogOut)")
              }
           case .fetchGoal:
            if let parameters = evObj.object as? [String: Any] {
              evObj.apiRequest = APIRouter.fetchGoals(params: parameters)
            } else {
              dLog(message: "Parameter Missing :: \(APIName.FetchGoals)")
            }
               // evObj.apiRequest = APIRouter.fetchGoals
           case .networkError:
              break

           case .saveUserFetchGoalDetails:
             if let parameters = evObj.object as? [String: Any] {
               evObj.apiRequest = APIRouter.savezGoalsDetails(params: parameters)
             } else {
               dLog(message: "Parameter Missing :: \(APIName.SaveGoalsDetails)")
             }
           case .forgotPassword:
              if let parameters = evObj.object as? [String: Any] {
                  evObj.apiRequest = APIRouter.forgotPassword(params: parameters)
              } else {
                 dLog(message: "Parameter Missing :: \(APIName.ForgotPassword)")
              }
           case .verifyCode:
              if let parameters = evObj.object as? [String: Any] {
                 evObj.apiRequest = APIRouter.verifyCode(params: parameters)
              } else {
                 dLog(message: "Parameter Missing :: \(APIName.VerifyCode)")
              }
           case .resetPassword:
              if let parameters = evObj.object as? [String: Any] {
                 evObj.apiRequest = APIRouter.ResetPassword(params: parameters)
              } else {
                 dLog(message: "Parameter Missing :: \(APIName.ResetPassword)")
             }
            case .getDataForLogPeriod:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.getDataForLogPeriod(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.getDataForLogPeriod)")
               }
            case .saveLogPeriod:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveLogPeriod(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveLogPeriod)")
               }
            case .getUserLogPeriodData:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.getUserLogPeriodData(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.getUserLogPeriodData)")
               }
            case .change_password:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.changePassword(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.changePassword)")
               }
            case .userProfile:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.userProfile(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.userProfile)")
               }
            case .saveUserMedications:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveUserMedications(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveUserMedications)")
               }
            case .saveUserProcedures:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveUserProcedures(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveUserProcedures)")
               }
            case .saveUserActivities:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveUserActivities(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveUserActivities)")
               }
            case .saveUserSymptoms:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveUserSymptoms(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveUserSymptoms)")
               }
            case .saveUserPregnancyTests:
                if let parameters = evObj.object as? [String: Any] {
                   evObj.apiRequest = APIRouter.saveUserPregnancyTests(params: parameters)
                } else {
                   dLog(message: "Parameter Missing :: \(APIName.saveUserPregnancyTests)")
               }
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

