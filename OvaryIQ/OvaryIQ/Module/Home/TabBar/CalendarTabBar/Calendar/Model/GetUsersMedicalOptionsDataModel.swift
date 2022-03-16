//
//  GetUsersMedicalOptionsDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/03/22.
//

import Foundation
// MARK: - GetUsersMedicalOptionsDataModel
struct GetUsersMedicalOptionsDataModel: Codable {
    var message: String?
    var medicalOptionsList: [MedicalOptionsList]
}

// MARK: - MedicalOptionsList
struct MedicalOptionsList: Codable {
    var name: String?
    var categoryImage: String?
    var subCategoryList: [SubCategoryList]
}

// MARK: - SubCategoryList
struct SubCategoryList: Codable {
    var id: Int
    var medicationID: String?
    var date, name: String?
    var procedureID, activityID, symptomID, pregnancyTestID: String?
    var subCategoryImage: String?
    var categoryImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case medicationID = "medication_id"
        case date, name
        case procedureID = "procedure_id"
        case activityID = "activity_id"
        case symptomID = "symptom_id"
        case pregnancyTestID = "pregnancy_test_id"
    }
}
