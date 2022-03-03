//
//  MyProfileDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/03/22.
//

import Foundation
// MARK: - MyProfileDataModel
struct MyProfileDataModel: Codable {
    let message: String?
    let userData: UserProfileDataModel?

    enum CodingKeys: String, CodingKey {
        case message
        case userData = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try? values.decodeIfPresent(String.self, forKey: .message) ?? ""
        userData = try? values.decodeIfPresent(UserProfileDataModel.self, forKey: .userData) ?? nil
    }
}

// MARK: - User
struct UserProfileDataModel: Codable {
    let id: Int?
    let name, email, mobile: String?
    let countryCode, profile: String?
    let userGoaldetails: [UserGoalDetailDataModel]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile
        case countryCode = "country_code"
        case profile
        case userGoaldetails = "user_goaldetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try? values.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try? values.decodeIfPresent(String.self, forKey: .email) ?? ""
        mobile = try? values.decodeIfPresent(String.self, forKey: .mobile) ?? ""
        countryCode = try? values.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        profile = try? values.decodeIfPresent(String.self, forKey: .profile) ?? ""
        userGoaldetails = try? values.decodeIfPresent([UserGoalDetailDataModel].self, forKey: .userGoaldetails) ?? nil
    }
}

// MARK: - UserGoaldetail
struct UserGoalDetailDataModel: Codable {
    let id, userID, goalID, birthYear: Int?
    let periodCycle: String?
    let startDateLastPeriod, totalDaysOfLastPeriod: Int?
    var daysDIFLastPeriod, daysDIFLastSecondPeriod, daysDIFLastThirdPeriod: Int?
    let avgCycle: Int?
    let daysInPeriod, goalStatus: String?
    let goal: Goal?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case goalID = "goal_id"
        case birthYear = "birth_year"
        case periodCycle = "period_cycle"
        case startDateLastPeriod = "start_date_last_period"
        case totalDaysOfLastPeriod = "total_days_of_last_period"
        case daysDIFLastPeriod = "days_dif_last_period"
        case daysDIFLastSecondPeriod = "days_dif_last_second_period"
        case daysDIFLastThirdPeriod = "days_dif_last_third_period"
        case avgCycle, daysInPeriod, goalStatus, goal
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        userID = try? values.decodeIfPresent(Int.self, forKey: .userID) ?? 0
        goalID = try? values.decodeIfPresent(Int.self, forKey: .goalID) ?? 0
        birthYear = try? values.decodeIfPresent(Int.self, forKey: .birthYear) ?? 0
        periodCycle = try? values.decodeIfPresent(String.self, forKey: .periodCycle) ?? ""
        startDateLastPeriod = try? values.decodeIfPresent(Int.self, forKey: .startDateLastPeriod) ?? 0
        totalDaysOfLastPeriod = try? values.decodeIfPresent(Int.self, forKey: .totalDaysOfLastPeriod) ?? 0
        daysDIFLastPeriod = try? values.decodeIfPresent(Int.self, forKey: .daysDIFLastPeriod) ?? 0
        daysDIFLastSecondPeriod = try? values.decodeIfPresent(Int.self, forKey: .daysDIFLastSecondPeriod) ?? 0
        daysDIFLastThirdPeriod = try? values.decodeIfPresent(Int.self, forKey: .daysDIFLastThirdPeriod) ?? 0
        daysDIFLastPeriod = try? values.decodeIfPresent(Int.self, forKey: .daysDIFLastPeriod) ?? 0
        avgCycle = try? values.decodeIfPresent(Int.self, forKey: .avgCycle) ?? 0
        daysInPeriod = try? values.decodeIfPresent(String.self, forKey: .daysInPeriod) ?? ""
        goalStatus = try? values.decodeIfPresent(String.self, forKey: .goalStatus) ?? ""
        goal = try? values.decodeIfPresent(Goal.self, forKey: .goal) ?? nil
    }
}

// MARK: - Goal
struct Goal: Codable {
    let id: Int?
    let goalType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case goalType = "goal_type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        goalType = try? values.decodeIfPresent(String.self, forKey: .goalType) ?? ""
    }
}
