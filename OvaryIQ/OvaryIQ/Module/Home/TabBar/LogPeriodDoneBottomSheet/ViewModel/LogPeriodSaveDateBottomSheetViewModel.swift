//
//  LogPeriodSaveDateBottomSheetVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/03/22.
//

import Foundation
import UIKit
protocol LogPeriodSaveDateBottomSheetViewModelDelegate {
      func sucessSaveLogPeriosApiResponse()
}

class LogPeriodSaveDateBottomSheetViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var saveMedicationRequestModel: SaveMedicationRequestModel?
    internal func registerCoreEngineEventsCallBack() {
        if self.restEventCallBackID == nil {
            self.registerRestEventCallBack()
        }
    }

    internal var delegate: LogPeriodSaveDateBottomSheetViewModelDelegate?
    internal func unregisterCoreEngineEventsCallBack() {
        if let callBackID = self.restEventCallBackID {
            self.coreEngine.unregisterEventForID(cbType: .restCallBack, regId: callBackID)
            self.restEventCallBackID = nil
        }
    }

    // MARK: - Private Functions - API Calls
    func callApiToSavePeriodAndMedications() {
         fLog()
        //let params = self.saveMedicationRequestModel.dictionary
        

        var dict = [String:Any]()
       dict["id"] = self.saveMedicationRequestModel?.medicationId?.first?.id?.description
        dict["date"] = self.saveMedicationRequestModel?.medicationId?.first?.date
//        dict["id"] = [1,2]
//        dict["date"] = "2022-01-06"
        let params = ["medication_id": [dict]]

         dLog(message: "Rest Event Name :: \(RestEvents.saveUserMedications) and Params :: \(String(describing: params))")
         let restEvent = RestEngineEvents(id: RestEvents.saveUserMedications, obj: params)
         Helper.showLoader()
       self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
    }

}
// MARK: - Register Rest Event Call Back

extension LogPeriodSaveDateBottomSheetViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
          //  guard let sself = self else { return }
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                case .saveUserMedications:
                    fLog()
                if isSuccess {
                    do {
                        self.delegate?.sucessSaveLogPeriosApiResponse()

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

extension Array {
    func toJSONStringFormatted() -> String? {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
                return String(data: jsonData, encoding: String.Encoding.utf8)!
            } catch {
                return nil
            }
        }
}
