//
//  CalendarHomeVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import Foundation
class CalendarHomeViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
   // internal var authSignupRequestModel = AuthSignUpRequestModel()
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
           // self.registerRestEventCallBack()
        }
    }

    internal var delegate: AuthSignUpViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
//     func callApiToSignUp() {
//         fLog()
//         let params = self.authSignupRequestModel.dictionary
//         dLog(message: "Rest Event Name :: \(RestEvents.SignUp) and Params :: \(String(describing: params))")
//         let restEvent = RestEngineEvents(id: RestEvents.SignUp, obj: params)
//         restEvent.showActivityIndicator = true
//
//        // self.view.showLoader()
////         ActivityIndicatorManager.sharedInstance.showLoader()
//        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
//        // self.coreEngine.addEvent(evObj: restEvent)
//    }
}
// MARK: - Register Rest Event Call Back
//extension CalendarHomeViewModel {
//    internal func registerRestEventCallBack() {
//        fLog()
//        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
//            if let eventId = RestEvents(rawValue: eventId) {
//                switch eventId {
//                case .SignUp:
//                    fLog()
//                if isSuccess {
//                    do {
//                        let encodedDictionary = try JSONDecoder().decode(AuthSignUpDataModel.self, from: JSONSerialization.data(withJSONObject: response))
//                        dLog(message: "signupResponse:- \(encodedDictionary)")
//                    } catch {
//                        print("Error: ", error)
//                    }
//                } else {
//                    AlertControllerManager.showToast(message: ErrorMessages.somethingWentWrong.localizedString, type: .error)
//                }
//
//                default:
//                    break
//                }
//            }
//        })
//    }
//}
