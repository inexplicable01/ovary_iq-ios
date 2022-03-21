//
//  ProjectionViewModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/03/22.
//

import Foundation
protocol ProjectionViewModelDelegate {
    func sucessProjectionApiResponse(projectionDataMod: ProjectionDataModel)
}

class ProjectionViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var delegate: ProjectionViewModelDelegate?
   // internal var viewContreoller = UIViewController()

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
     func callApiToGetProjectionData() {
         fLog()
     //    let params = [self.validateSocialIdRequestModel.dictionary]
         dLog(message: "Rest Event Name :: \(RestEvents.projectionData) and Params :: \(String(describing: [:]))")
         let restEvent = RestEngineEvents(id: RestEvents.projectionData, obj: [:])
         Helper.showLoader()
         self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
         //self.coreEngine.addEvent(evObj: restEvent)
    }

}
extension ProjectionViewModel {

    internal func registerRestEventCallBack() {
        fLog()

        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { [weak self] (eventId, result, response, message, isSuccess) in
        //    guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {

                switch eventId {
                case .projectionData:
                    fLog()
                    if isSuccess {
                       // sself.handleResponseForRegistration(response: response)
                        do {
                            let encodedDictionary = try JSONDecoder().decode(ProjectionDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                            dLog(message: "projectionResponse:- \(encodedDictionary)")
                            self?.delegate?.sucessProjectionApiResponse(projectionDataMod: encodedDictionary)
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
