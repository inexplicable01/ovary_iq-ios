//
//  ForgotPasswordViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
import UIKit
@objc protocol ForgotPasswordViewModelDelegate {
    @objc optional func sucessForgotPasswordApiResponse(code: String?)
}

class ForgotPasswordViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var forgotPasswordRequestModel = ForgotPasswordRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }
    internal var delegate: ForgotPasswordViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToForgotPassword() {
         fLog()
         let params = self.forgotPasswordRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.forgotPassword) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.forgotPassword, obj: params)
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension ForgotPasswordViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .forgotPassword:
                    fLog()
                if isSuccess {
                    do {

                        let encodedDictionary = try JSONDecoder().decode(ForgotPasswordDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "signupResponse:- \(encodedDictionary)")
                        self.delegate?.sucessForgotPasswordApiResponse?(code: encodedDictionary.tokenData?.token ?? "")
                      

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
