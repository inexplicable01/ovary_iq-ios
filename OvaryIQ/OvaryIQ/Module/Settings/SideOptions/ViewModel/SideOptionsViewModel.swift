//
//  ProfileVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 23/02/22.
//

import Foundation
import UIKit
class SideOptionsViewModel {
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
          //  self.registerRestEventCallBack()
        }
    }
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
