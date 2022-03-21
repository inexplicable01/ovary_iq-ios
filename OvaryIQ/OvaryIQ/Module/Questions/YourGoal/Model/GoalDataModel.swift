//
//  GoalDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/02/22.
//

import Foundation
// MARK: - DataClass
struct GoalDataModel: Codable {
    var message: String?
    var goalType: [GoalTypeModel]?

    enum CodingKeys: String, CodingKey {
        case message
        case goalType = "goals"
    }
}

// MARK: - Goal
struct GoalTypeModel: Codable {
  var id: Int?
  var goalType: String?
  var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case goalType = "goal_type"
    }
}
