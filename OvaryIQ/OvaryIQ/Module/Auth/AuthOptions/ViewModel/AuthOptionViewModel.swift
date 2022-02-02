//
//  AuthOptionViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
import UIKit
class AuthOptionViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var validateSocialIdRequestModel = ValidateSocialIdRequest()
    internal var viewContreoller = UIViewController()
    // MARK: - Init & AuthOptionViewModelProtocol
//    required init(coreEngine: CoreEngine) {
//        self.coreEngine = coreEngine
//    }

    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    internal func validateSocialId(loginType: LoginType) {
        fLog()

        if loginType == LoginType.apple {
            AppleSignInManager.shared.login { [weak self] (socialUserInfo, message, success) in
               // guard let sself = self else { return }
                if !success {
                    dLog(message: "Error :: Apple Login Failed.")
                    // sself.validateSocialIdRequestFailed.send(AppError.somethingWentWrong)
                } else {
                    if let userInfo = socialUserInfo {
                        self?.validateSocialIdRequestModel.loginType = loginType.rawValue
                        self?.validateSocialIdRequestModel.socialId = userInfo.socialId
//
//                        sself.registrationRequestModel.loginType = loginType.rawValue
//                        sself.registrationRequestModel.socialId = userInfo.socialId
//                        sself.registrationRequestModel.firstName = userInfo.firstName
//                        sself.registrationRequestModel.lastName = userInfo.lastName
//                        sself.registrationRequestModel.email = userInfo.email

                        if ((self?.validateSocialIdRequestModel.socialId.isEmpty) != nil) {
                            dLog(message: "Error :: Social Id is Empty.")
                           // validateSocialIdRequestFailed.send(ErrorMessages.somethingWentWrong)
                            return
                        } else {
                            //sself.callApiToValidateSocialId()
                        }
                    }
                }
            }
        } else if loginType == LoginType.google {
            GoogleManager.shared.login(viewController: viewContreoller) { (socialUserInfo, message, success) in
                if !success {
                    // Utility.showToast(message: message ?? "Google Login Error")
                } else {
                    if let userInfo = socialUserInfo {
                        fLog()
                       print("Google user details:- ", userInfo)
                    }
                }
            }
        } else {
            dLog(message: "Error :: Unable to Find the Root View Controller.")
          //  self.validateSocialIdRequestFailed.send(AppError.somethingWentWrong)
        }
    }
}
extension AuthOptionViewModel {

    internal func registerRestEventCallBack() {
        fLog()

        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { [weak self] (eventId, result, response, message, isSuccess) in
        //    guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {

                switch eventId {
                case .SignUp:
                    fLog()
                    if isSuccess {
                       // sself.handleResponseForRegistration(response: response)
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
