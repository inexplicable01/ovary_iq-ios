//
//  TryingGetPrefnantRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/02/22.
//

import Foundation
struct TryingGetPreganantRequestModel: Codable {
    var goalId: String?
    var birthYear: String?
    var tryingMonthsToPregnant: Int?
    var periodCycle: String = ""
    var startDateLastPeriod: Int?
    var totalDaysOfLastPeriod: Int?
    var daysDifLastPeriod: Int?
    var daysDifLastSecondPeriod: Int?
    var daysDifLastThirdPeriod: Int?
    enum CodingKeys: String, CodingKey {
        case goalId = "goal_id"
        case birthYear = "birth_year"
        case tryingMonthsToPregnant = "trying_months_to_pregnant"
        case periodCycle = "period_cycle"
        case startDateLastPeriod = "start_date_last_period"
        case totalDaysOfLastPeriod = "total_days_of_last_period"
        case daysDifLastPeriod = "days_dif_last_period"
        case daysDifLastSecondPeriod = "days_dif_last_second_period"
        case daysDifLastThirdPeriod = "days_dif_last_third_period"
    }
}
