//
//  GetDataForLogPeriodDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 03/03/22.
//

import Foundation
// MARK: - GetDataForLogPeriodDataModel
struct GetDataForLogPeriodDataModel: Codable {
    var message: String?
    var medicalOptionsList: [MedicalOptionsListDataModel]
    
    enum CodingKeys: String, CodingKey {
        case message
        case medicalOptionsList = "medicalOptionsList"
    }
}
// MARK: - MedicalOptionsList
struct MedicalOptionsListDataModel: Codable {
    var name: String?
    var categoryImage: String?
    var subCategoryList: [SubCategoryListDataModel]
}

// MARK: - SubCategoryList
struct SubCategoryListDataModel: Codable {
    var id: Int?
    var isSelected: Bool?
    var periodFlowName: String?
    var periodFlowIcon: String?
    var medicationName: String?
    var medicationIcon: String?
    var procedureName: String?
    var procedureIcon: String?
    var activityName: String?
    var activityIcon: String?
    var symptomName: String?
    var symptomIcon: String?
    var pregnancyTestName: String?
    var pregnancyTestIcon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case periodFlowName = "period_flow_name"
        case periodFlowIcon = "period_flow_icon"
        case medicationName = "medication_name"
        case medicationIcon = "medication_icon"
        case procedureName = "procedure_name"
        case procedureIcon = "procedure_icon"
        case activityName = "activity_name"
        case activityIcon = "activity_icon"
        case symptomName = "symptom_name"
        case symptomIcon = "symptom_icon"
        case pregnancyTestName = "pregnancy_test_name"
        case pregnancyTestIcon = "pregnancy_test_icon"
    }

}
