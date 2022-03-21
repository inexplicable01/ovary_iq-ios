//
//  SaveFetchGoalDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 05/02/22.
//

import Foundation

// MARK: - SaveFetchGoalDataModel
struct SaveFetchGoalDataModel: Codable {
    let message: String?
    let saveDetail: SaveDetailDataModel?

    enum CodingKeys: String, CodingKey {
        case message
        case saveDetail = "save_detail"
    }
}

// MARK: - SaveDetail
struct SaveDetailDataModel: Codable {
    let goalID, birthYear, periodCycle, startDateLastPeriod: String?
    let totalDaysOfLastPeriod, daysDIFLastPeriod: String?
    let daysDIFLastSecondPeriod, daysDIFLastThirdPeriod: String?
    let userID: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case goalID = "goal_id"
        case birthYear = "birth_year"
        case periodCycle = "period_cycle"
        case startDateLastPeriod = "start_date_last_period"
        case totalDaysOfLastPeriod = "total_days_of_last_period"
        case daysDIFLastPeriod = "days_dif_last_period"
        case daysDIFLastSecondPeriod = "days_dif_last_second_period"
        case daysDIFLastThirdPeriod = "days_dif_last_third_period"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
