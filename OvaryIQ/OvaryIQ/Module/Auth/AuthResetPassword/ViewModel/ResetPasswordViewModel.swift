//
//  ResetPasswordViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
import UIKit
@objc protocol ResetPasswordViewModelDelegate {
    @objc optional func sucessResetPasswordApiResponse()
}

class ResetPasswordViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var resetPasswordRequestModel = ResetPasswordRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: ResetPasswordViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToResetPassword() {
         fLog()
         let params = self.resetPasswordRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.resetPassword) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.resetPassword, obj: params)
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension ResetPasswordViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .resetPassword:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(ResetPasswordDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "ResetPasswordResponse:- \(encodedDictionary)")

                       self.delegate?.sucessResetPasswordApiResponse?()

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
