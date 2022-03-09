//
//  ProjectionDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/03/22.
//

import Foundation
// MARK: - WelcomeData
struct ProjectionDataModel: Codable {
    let message: String?
    let data: ProjectionDetailDataModel?
}

// MARK: - DataData
struct ProjectionDetailDataModel: Codable {
    let pregnancyTestDate, expectedDeliveryDate, gestationDays, procedureDate: String?
    let procedureName: String?
    enum CodingKeys: String, CodingKey {
        case pregnancyTestDate, expectedDeliveryDate, gestationDays, procedureDate
        case procedureName = "ProcedureName"
    }
    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
        pregnancyTestDate = try? values.decodeIfPresent(String.self, forKey: .pregnancyTestDate) ?? ""
        expectedDeliveryDate = try? values.decodeIfPresent(String.self, forKey: .expectedDeliveryDate) ?? ""
        procedureDate = try? values.decodeIfPresent(String.self, forKey: .procedureDate) ?? ""
        procedureName = try? values.decodeIfPresent(String.self, forKey: .procedureName) ?? ""
        gestationDays = try? values.decodeIfPresent(String.self, forKey: .gestationDays) ?? ""
    }
}
