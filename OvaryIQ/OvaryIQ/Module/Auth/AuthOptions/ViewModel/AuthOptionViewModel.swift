//
//  AuthOptionViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
import UIKit

@objc protocol AuthOptionViewModelDelegate {
    @objc optional func sucessLoginSocialApiResponse()
}

class AuthOptionViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var validateSocialIdRequestModel = ValidateSocialIdRequest()
    internal var delegate: AuthOptionViewModelDelegate?
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
                        self?.validateSocialIdRequestModel.email = userInfo.email
                        self?.validateSocialIdRequestModel.socialId = userInfo.socialId
                        self?.validateSocialIdRequestModel.loginType = userInfo.type.rawValue
                        self?.validateSocialIdRequestModel.name = userInfo.name
                        self?.validateSocialIdRequestModel.profile = userInfo.profilePic
                        self?.callApiToSocialLogin()

//                        if ((self?.validateSocialIdRequestModel.socialId.isEmpty) != nil) {
//                            dLog(message: "Error :: Social Id is Empty.")
//                           // validateSocialIdRequestFailed.send(ErrorMessages.somethingWentWrong)
//                            return
//                        } else {
//                            //sself.callApiToValidateSocialId()
//                        }
                    }
                }
            }
        } else if loginType == LoginType.google {
            GoogleManager.shared.login(viewController: viewContreoller) { (socialUserInfo, message, success) in
                if !success {
                    dLog(message: "Google Login Error")
                    // Utility.showToast(message: message ?? "Google Login Error")
                } else {
                    if let userInfo = socialUserInfo {
                        fLog()
                       print("Google user details:- ", userInfo)

                        self.validateSocialIdRequestModel.email = userInfo.email
                        self.validateSocialIdRequestModel.socialId = userInfo.socialId
                        self.validateSocialIdRequestModel.loginType = userInfo.type.rawValue
                        self.validateSocialIdRequestModel.name = userInfo.name
                        self.validateSocialIdRequestModel.profile = userInfo.profilePic

                        self.callApiToSocialLogin()

                    }
                }
            }
        } else {
            dLog(message: "Error :: Unable to Find the Root View Controller.")
          //  self.validateSocialIdRequestFailed.send(AppError.somethingWentWrong)
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToSocialLogin() {
         fLog()
         let params = self.validateSocialIdRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.login) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.login, obj: params)
        //restEvent.showActivityIndicator = true
         Helper.showLoader()
       self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         //self.coreEngine.addEvent(evObj: restEvent)
    }

}
extension AuthOptionViewModel {

    internal func registerRestEventCallBack() {
        fLog()

        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { [weak self] (eventId, result, response, message, isSuccess) in
        //    guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {

                switch eventId {
                case .login:
                    fLog()
                    if isSuccess {
                       // sself.handleResponseForRegistration(response: response)

                        do {
                            let encodedDictionary = try JSONDecoder().decode(AuthSignUpDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                            dLog(message: "socialLoginResponse:- \(encodedDictionary)")
                            // 1. Save Access Token
                            if let acessToken = encodedDictionary.accessToken {
                                kUserDefaults.accessToken = acessToken
                            }
                            if let isGoalSaved = encodedDictionary.isGoalSaved {
                                kUserDefaults.isGoalSaved = isGoalSaved
                            }
                            self?.delegate?.sucessLoginSocialApiResponse?()

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
