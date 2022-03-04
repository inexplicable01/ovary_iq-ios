//
//  ChangePasswordVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/03/22.
//

import Foundation
//ChangePasswordViewModel
//
//  ResetPasswordViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
import UIKit
@objc protocol ChangePasswordViewModelDelegate {
    @objc optional func sucessChangePasswordApiResponse()
}

class ChangePasswordViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var changePasswordRequestModel = ChangePasswordRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: ChangePasswordViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
     func callApiToChangePassword() {
         fLog()
         let params = self.changePasswordRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.change_password) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.change_password, obj: params)
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension ChangePasswordViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .change_password:
                    fLog()
                if isSuccess {
                    self.delegate?.sucessChangePasswordApiResponse?()
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
