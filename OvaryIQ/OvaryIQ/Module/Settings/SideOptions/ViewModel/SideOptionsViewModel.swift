//
//  ProfileVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 23/02/22.
//

import Foundation
import UIKit
protocol SideOptionsViewModelDeleagte {
    func sendSuccessResponseOfUpdateProfile(profileDataModel: MyProfileDataModel)
}

class SideOptionsViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var delegate: SideOptionsViewModelDeleagte?
    //internal var validateSocialIdRequestModel = ValidateSocialIdRequest()
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
     internal func callApiTologout() {
         fLog()
//         let params = self.authSignupRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.logout)")
         let restEvent = RestEngineEvents(id: RestEvents.logout, obj: [:])
         restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
        // self.coreEngine.addEvent(evObj: restEvent)
    }
    // MARK: - Private Functions - API Calls

    internal func callApiToEditPhotos(image: UIImage) {
        fLog()
        var params = [String: Any]()
//
//        var images = [UIImage]()
//        for photo in self.photos {
//            if let photo = photo.photo {
//                images.append(photo)
//            }
//        }
        params[APIParam.profile] = image
        params[APIParam.keyName] = APIParam.profile

    dLog(message: "Rest Event Name :: \(RestEvents.updateProfilePhoto) and Params :: \(String(describing: params))")

        let restEvent = RestEngineEvents(id: RestEvents.updateProfilePhoto, obj: params)
        restEvent.fastQueue = false
        restEvent.downloadingFile = false
        restEvent.uploadMultipart = true
        Helper.showLoader()
        restEvent.showActivityIndicator = false
        self.coreEngine.addEvent(evObj: restEvent)
       // self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
    }
}
// MARK: - Register Rest Event Call Back

extension SideOptionsViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .updateProfilePhoto:
                    fLog()
                if isSuccess {
                    do {
                        let encodedDictionary = try JSONDecoder().decode(MyProfileDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                        dLog(message: "updateProfilePhoto:- \(encodedDictionary)")
                        // 1. Save profile photo
                        if let profilePhoto = encodedDictionary.userData?.profile {
                            kUserDefaults.ProfilePhoto = profilePhoto
                        }
                        self.delegate?.sendSuccessResponseOfUpdateProfile(profileDataModel: encodedDictionary)

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
