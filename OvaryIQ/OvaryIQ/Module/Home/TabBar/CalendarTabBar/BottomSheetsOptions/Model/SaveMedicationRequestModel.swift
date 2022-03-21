//
//  SaveMedicationRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/03/22.
//

import Foundation
struct SaveMedicationRequestModel: Codable {
    var periodType: String?
    var medicationId: [MedicationModel]?
//    var procedureId: [MedicationModel]?
//    var
    enum CodingKeys: String, CodingKey {
        case medicationId = "medication_id"
        case periodType = "periodType"
    }
}
struct MedicationModel: Codable {
    var id: [Int]?
    var date: String = ""
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
    }
}
