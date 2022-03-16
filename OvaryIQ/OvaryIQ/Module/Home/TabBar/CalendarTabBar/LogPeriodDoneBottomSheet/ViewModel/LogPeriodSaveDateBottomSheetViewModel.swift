//
//  LogPeriodSaveDateBottomSheetVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/03/22.
//

import Foundation
import UIKit
protocol LogPeriodSaveDateBottomSheetViewModelDelegate {
    func sucessSaveLogPeriosApiResponse(eventType: RestEvents)
}
class LogPeriodSaveDateBottomSheetViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    private var params = [String: Any]()
    private var dict = [[String: Any]]()
    private var restEngineEvent = EngineEvents()
    internal var saveMedicationRequestModel: SaveMedicationRequestModel?
    internal var saveUserSelectedLogPeriodRequestModel: SaveUserLogPeriodDataRequestModel?
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
    func callApiToSavePeriodAndMedications(type: String) {
         fLog()

//        dict[APIParam.id] = self.saveMedicationRequestModel?.medicationId?.first?.id
//        dict[APIParam.date] = self.saveMedicationRequestModel?.medicationId?.first?.date


        if let medicationsIdsArr = self.saveMedicationRequestModel?.medicationId {
            for (inx,mod) in medicationsIdsArr.enumerated() {
                var newdict = [String : Any]()
                newdict[APIParam.id] = self.saveMedicationRequestModel?.medicationId?[inx].id
                newdict[APIParam.date] = self.saveMedicationRequestModel?.medicationId?[inx].date
                dict.append(newdict)
            }
        }
        switch self.saveMedicationRequestModel?.periodType {
                // for Log Period
         case LogPeriodCategoryType.logPeriod.rawValue:
          if let periodFlowId = self.saveMedicationRequestModel?.medicationId?.first?.id?.first {
                self.saveUserSelectedLogPeriodRequestModel?.periodFlowId = "\(periodFlowId)"
          }
         self.saveUserSelectedLogPeriodRequestModel?.lockDate = self.saveMedicationRequestModel?.medicationId?.first?.date
         params = self.saveUserSelectedLogPeriodRequestModel.dictionary
         dLog(message: "Rest Event Name :: \(RestEvents.saveLogPeriod) and Params :: \(String(describing: params))")
         restEngineEvent = RestEngineEvents(id: RestEvents.saveLogPeriod, obj: params)
                // for Medications
        case LogPeriodCategoryType.medication.rawValue:
        params = [APIParam.MedicationId: dict.toJSONStringFormatted()]
        dLog(message: "Rest Event Name :: \(RestEvents.saveUserMedications) and Params :: \(String(describing: params))")
        restEngineEvent = RestEngineEvents(id: RestEvents.saveUserMedications, obj: params)
          // for Procedure
        case LogPeriodCategoryType.procedure.rawValue:
        params = [APIParam.ProcedureId: dict.toJSONStringFormatted()]
        dLog(message: "Rest Event Name :: \(RestEvents.saveUserProcedures) and Params :: \(String(describing: params))")
        restEngineEvent = RestEngineEvents(id: RestEvents.saveUserProcedures, obj: params)
                // for Activity
        case LogPeriodCategoryType.activity.rawValue:
        params = [APIParam.ActivityId: dict.toJSONStringFormatted()]
        dLog(message: "Rest Event Name :: \(RestEvents.saveUserActivities) and Params :: \(String(describing: params))")
        restEngineEvent = RestEngineEvents(id: RestEvents.saveUserActivities, obj: params)
                // for Symptoms
        case LogPeriodCategoryType.symptoms.rawValue:
        params = [APIParam.SymptomId: dict.toJSONStringFormatted()]
        dLog(message: "Rest Event Name :: \(RestEvents.saveUserSymptoms) and Params :: \(String(describing: params))")
        restEngineEvent = RestEngineEvents(id: RestEvents.saveUserSymptoms, obj: params)
               //for Pregnancy Test
        case LogPeriodCategoryType.pregnancyTest.rawValue:
                params = [APIParam.PregnancyTestId: dict.toJSONStringFormatted() ?? [:]]
        dLog(message: "Rest Event Name :: \(RestEvents.saveUserPregnancyTests) and Params :: \(String(describing: params))")
        restEngineEvent = RestEngineEvents(id: RestEvents.saveUserPregnancyTests, obj: params)
        default:
        break
        }
       Helper.showLoader()
      self.coreEngine.addEngineEventsWithOutWait(evObj: restEngineEvent)

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
                    case .saveUserMedications, .saveLogPeriod, .saveUserSymptoms,.saveUserProcedures, .saveUserActivities, .saveUserPregnancyTests:
                    fLog()
                 if isSuccess {
                    do {
                        self.delegate?.sucessSaveLogPeriosApiResponse(eventType: eventId)

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
