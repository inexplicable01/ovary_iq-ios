//
//  AuthVerificationCodeViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
//
//  AuthSignUpViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//

import Foundation
import UIKit
@objc protocol AuthVerificationViewModelDelegate {
    @objc optional func sucessVerificationCodeApiResponse(code: String?)
}

class AuthVerificationViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var authVerificationCodeRequestModel = AuthVerificationCodeRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: AuthVerificationViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToVerifyOtp() {
         fLog()
         let params = self.authVerificationCodeRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.verifyCode) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.verifyCode, obj: params)
         restEvent.showActivityIndicator = true
       // self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension AuthVerificationViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .verifyCode:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(AuthVerificationDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "signupResponse:- \(encodedDictionary)")

                        self.delegate?.sucessVerificationCodeApiResponse?(code: encodedDictionary.data?.token ?? "")

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
