//
//  LastPeriodLongViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 05/02/22.

import Foundation
import UIKit
@objc protocol LastPeriodViewModelDelegate {
    @objc optional func sucesssSaveGoalsApiResponse()
}

class LastPeriodViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var fetchGoalRequestModel = TryingGetPreganantRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: LastPeriodViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiTosaveFetchGoalDetails() {
         fLog()
         let params = self.fetchGoalRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.saveUserFetchGoalDetails) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.saveUserFetchGoalDetails, obj: params)
         restEvent.showActivityIndicator = true
       self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         //self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension LastPeriodViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .saveUserFetchGoalDetails:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(SaveDetailDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "saveUserGoalResponse:- \(encodedDictionary)")
                        kUserDefaults.isGoalSaved = true
                        self.delegate?.sucesssSaveGoalsApiResponse?()

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
