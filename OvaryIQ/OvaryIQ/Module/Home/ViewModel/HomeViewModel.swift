//
//  AuthSignUpViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//

import Foundation
import UIKit
@objc protocol HomeViewModelDelegate {
    @objc optional func sucessLogoutApiResponse()
}

class HomeViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var authSignupRequestModel = AuthSignUpRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: HomeViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiTologout() {
         fLog()
//         let params = self.authSignupRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.logout)")
         let restEvent = RestEngineEvents(id: RestEvents.logout, obj: [:])
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }
}
// MARK: - Register Rest Event Call Back

extension HomeViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .SignUp:
                    fLog()
                if isSuccess {
                    do {

                       self.delegate?.sucessLogoutApiResponse?()

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

