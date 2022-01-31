//
//  AuthSignUpDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
struct AuthSignUpDataModel: Codable {
    var name: String?
    var email: String?
    var mobile: String?
    var updatedAt: String?
    var createdAt: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(Int.self, forKey: .name)
//        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
//        userType = try values.decodeIfPresent(String.self, forKey: .userType)
//        value = try values.decodeIfPresent(String.self, forKey: .value)
//        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
//        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
//        organizationID = try values.decodeIfPresent(Int.self, forKey: .organizationID)
//    }
}
