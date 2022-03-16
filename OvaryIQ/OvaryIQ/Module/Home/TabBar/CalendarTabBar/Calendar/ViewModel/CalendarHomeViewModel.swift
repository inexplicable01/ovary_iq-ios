//
//  CalendarHomeVM.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import Foundation
protocol CalendarHomeViewModelDelegate {
    func getDataForlogPeriodResponse(dataModel: GetDataForLogPeriodDataModel)
    func getUsersMedicalOptionsDataModel(medicalOptionsDataModel: GetUsersMedicalOptionsDataModel)
    func getUserlogPeriodResponse(dataModel: GetUserLogPeriodDataModel)
}
class CalendarHomeViewModel {
    // MARK: - Properties
    private var restEventCallBackID: String?
    private let coreEngine = CoreEngine.shared
    internal var delegate: CalendarHomeViewModelDelegate?
    // internal var authSignupRequestModel = AuthSignUpRequestModel()
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

    // MARK: - Private And Internal Functions - API Calls
    internal func callApiToGetDataForLogPeriod() {
        fLog()
        dLog(message: "Rest Event Name :: \(RestEvents.getDataForLogPeriod) and Params :: \(String(describing: [:]))")
        let restEvent = RestEngineEvents(id: RestEvents.getDataForLogPeriod, obj: [:])
        restEvent.showActivityIndicator = true
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
    }
    internal func callApiToGetUserLogPeriodData() {
        fLog()
        dLog(message: "Rest Event Name :: \(RestEvents.getUserLogPeriodData) and Params :: \(String(describing: [:]))")
        let restEvent = RestEngineEvents(id: RestEvents.getUserLogPeriodData, obj: [:])
        restEvent.showActivityIndicator = false
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
    }
    internal func callApiToGetUsersMedicalOptionsData() {
        fLog()
        dLog(message: "Rest Event Name :: \(RestEvents.getUsersMedicalOptionsData) and Params :: \(String(describing: [:]))")
        let restEvent = RestEngineEvents(id: RestEvents.getUsersMedicalOptionsData, obj: [:])
        restEvent.showActivityIndicator = false
        self.coreEngine.addEngineEventsWithOutWait(evObj: restEvent)
    }


}
// MARK: - Register Rest Event Call Back
extension CalendarHomeViewModel {
    internal func registerRestEventCallBack() {
        fLog()
        self.restEventCallBackID = self.coreEngine.registerEventCallBack(cbType: .restCallBack, cbBlock: { eventId, result, response, message, isSuccess in
            if let eventId = RestEvents(rawValue: eventId) {
                switch eventId {
                    case .getDataForLogPeriod:
                        fLog()
                        if isSuccess {
                            do {
                                self.callApiToGetUserLogPeriodData()
                                var encodedDictionary = try JSONDecoder().decode(GetDataForLogPeriodDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                                dLog(message: "GetUSerSavedLogPeriodResponse:- \(encodedDictionary)")
                                var newModel = encodedDictionary
                                for (indx,value) in newModel.medicalOptionsList.enumerated() {
                                    newModel.medicalOptionsList[indx].categoryImage = Helper.getIcon(name: value.name ?? "")
                                    for (inx, subValue) in value.subCategoryList.enumerated() {
                                        newModel.medicalOptionsList[indx].subCategoryList[inx].isSelected = false
                                        switch value.name {
                                            case LogPeriodCategoryType.logPeriod.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].periodFlowIcon = Helper.getIcon(name: subValue.periodFlowName ?? "")
                                            case LogPeriodCategoryType.medication.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].medicationIcon = Helper.getIcon(name: subValue.medicationName ?? "")
                                            case LogPeriodCategoryType.procedure.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].procedureIcon = Helper.getIcon(name: subValue.procedureName ?? "")
                                            case LogPeriodCategoryType.activity.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].activityIcon = Helper.getIcon(name: subValue.activityName ?? "")
                                            case LogPeriodCategoryType.symptoms.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].symptomIcon = Helper.getIcon(name: subValue.symptomName ?? "")
                                            case LogPeriodCategoryType.pregnancyTest.rawValue:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].pregnancyTestIcon = Helper.getIcon(name: subValue.pregnancyTestName ?? "")
                                            default:
                                                newModel.medicalOptionsList[indx].subCategoryList[inx].periodFlowIcon = Helper.getIcon(name: subValue.periodFlowName ?? "")

                                        }

                                    }
                                }


                                self.delegate?.getDataForlogPeriodResponse(dataModel: newModel)
                            } catch {
                                print("Error: ", error)
                            }
                        } else {
                            AlertControllerManager.showToast(message: ErrorMessages.somethingWentWrong.localizedString, type: .error)
                        }

                    case .getUsersMedicalOptionsData:
                        if isSuccess {
                            do {
                                let encodedDictionary = try JSONDecoder().decode(GetUsersMedicalOptionsDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                                dLog(message: "getUsersMedicalOptionsDataResponse:- \(encodedDictionary)")
//                                var medicalOptionModel = encodedDictionary
//                                for (indx,value) in medicalOptionModel.medicalOptionsList.enumerated() {
//                                    medicalOptionModel.medicalOptionsList[indx].categoryImage = Helper.getIcon(name: value.name ?? "")
//                                    for (inx, subValue) in value.subCategoryList.enumerated() {
//                                        medicalOptionModel.medicalOptionsList[indx].subCategoryList[inx].subCategoryImage = Helper.getIcon(name: subValue.name ?? "")
//                                    }
//                                }
                                self.delegate?.getUsersMedicalOptionsDataModel(medicalOptionsDataModel: encodedDictionary)

                            } catch {
                                print("Error: ", error)
                            }
                        } else {
                            AlertControllerManager.showToast(message: ErrorMessages.somethingWentWrong.localizedString, type: .error)
                        }
                    case .getUserLogPeriodData:
                        if isSuccess {
                            do {
                                let encodedDictionary = try JSONDecoder().decode(GetUserLogPeriodDataModel.self, from: JSONSerialization.data(withJSONObject: response))
                                dLog(message: "getUserLogPeriodDataRespons:- \(encodedDictionary)")
                                self.delegate?.getUserlogPeriodResponse(dataModel: encodedDictionary)

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
