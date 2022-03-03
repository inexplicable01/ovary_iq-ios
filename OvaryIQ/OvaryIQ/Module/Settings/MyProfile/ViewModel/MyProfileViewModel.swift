//
//  MyProfileViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/03/22.
//

import Foundation
class MyProfileViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
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
     func callApiTogetUserProfile() {
         fLog()
//         let params = self.authSignupRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.userProfile)")
         let restEvent = RestEngineEvents(id: RestEvents.userProfile, obj: [:])
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }
}
