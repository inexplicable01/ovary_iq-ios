//
//  AuthSignUpViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//

import Foundation
import UIKit
protocol GoalViewModelDelegate {
     func sucessResponseFetchGoal(dataModel: GoalDataModel?)
}

class GoalViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var authLoginRequestModel = AuthLoginRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: GoalViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToFetchGoalResponse() {
         fLog()
         let params = [String: Any]()
         dLog(message: "Rest Event Name :: \(RestEvents.fetchGoal) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.fetchGoal, obj: params)
         restEvent.showActivityIndicator = true
       self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         //self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension GoalViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .fetchGoal:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(GoalDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "GoalResponse:- \(encodedDictionary)")
                        self.delegate?.sucessResponseFetchGoal(dataModel: encodedDictionary)

                    } catch {
                        print("Error: ", error)
                    }
                } else {
                    AlertControllerManager.showToast(message: ErrorMessages.somethingWentWrong.localizedString, type: .error)
                }

                default:
                    break
                }
            }
        })
    }
}
