//
//  MyProfileViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/03/22.
//

import Foundation
protocol MyProfileViewModelDelegate {
     func sucessUserProfileApiResponse(profileDataModel: MyProfileDataModel)
}
class MyProfileViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var delegate: MyProfileViewModelDelegate?
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
// MARK: - Register Rest Event Call Back

extension MyProfileViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .userProfile:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(MyProfileDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "ResetPasswordResponse:- \(encodedDictionary)")
                        self.delegate?.sucessUserProfileApiResponse(profileDataModel: encodedDictionary)

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
