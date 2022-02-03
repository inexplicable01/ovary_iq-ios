//
//  AuthSignUpViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//

import Foundation
import UIKit
@objc protocol LoginViewModelDelegate {
    @objc optional func sucessLoginApiResponse()
}

class AuthLoginViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var authLoginRequestModel = AuthLoginRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: LoginViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToLogin() {
         fLog()
         let params = self.authLoginRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.login) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.login, obj: params)
         restEvent.showActivityIndicator = true
       self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         //self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension AuthLoginViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .login:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(AuthSignUpDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "signupResponse:- \(encodedDictionary)")
                        // 1. Save Access Token
                        if let acessToken = encodedDictionary.accessToken {
                            kUserDefaults.accessToken = acessToken
                        }
                        if let tokenType = encodedDictionary.tokenType {
                            kUserDefaults.tokenType = tokenType
                       }
                        self.delegate?.sucessLoginApiResponse?()

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
