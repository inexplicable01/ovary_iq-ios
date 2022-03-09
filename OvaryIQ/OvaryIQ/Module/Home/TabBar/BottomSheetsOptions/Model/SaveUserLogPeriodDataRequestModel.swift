//
//  SaveLogPeriodDataRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 08/03/22.
//

import Foundation
//SaveLogPeriodDataRequestModel
struct SaveUserLogPeriodDataRequestModel: Codable {
    var periodFlowId: String?
    var lockDate: String?
    var id: Int?
    enum CodingKeys: String, CodingKey {
        case periodFlowId = "period_flow_id"
        case lockDate = "lock_date"
        case id = "id"
    }
}
