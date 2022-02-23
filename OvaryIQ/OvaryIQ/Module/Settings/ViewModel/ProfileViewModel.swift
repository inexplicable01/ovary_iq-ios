//
//  ProfileVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 23/02/22.
//

import Foundation
import UIKit
class ProfileViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    //internal var validateSocialIdRequestModel = ValidateSocialIdRequest()
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
}
extension ProfileViewModel {

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
