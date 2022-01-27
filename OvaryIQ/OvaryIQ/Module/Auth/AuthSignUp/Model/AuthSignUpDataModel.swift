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
}
