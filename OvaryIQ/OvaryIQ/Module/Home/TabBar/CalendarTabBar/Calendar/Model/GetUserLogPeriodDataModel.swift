//
//  GetUserLogPeriodDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 08/03/22.
//

import Foundation
//GetUserLogPeriodDataModel
// MARK: - DataClass
struct GetUserLogPeriodDataModel: Codable {
    let message: String?
    let logData: [LogDataModel]?
    let predictions: PredictionsDataModel?
}

// MARK: - LogData
struct LogDataModel: Codable {
    let id, goalID: Int?
    let goalName: String?
    let periodFlowID: Int?
    let lockDate, periodFlowName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case goalID = "goalId"
        case goalName
        case periodFlowID = "periodFlowId"
        case lockDate, periodFlowName
    }
}
// MARK: - Predictions
struct PredictionsDataModel: Codable {
    let predictedPeriod, ovulation, fertileWindow: String?
    let isExist: Bool?
}
