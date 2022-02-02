//
//  AuthSignUpDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
struct AuthSignUpDataModel: Codable {
    let message, accessToken, tokenType: String?
    let expiresIn: Int?
    let user: User?

       enum CodingKeys: String, CodingKey {
           case message
           case accessToken = "access_token"
           case tokenType = "token_type"
           case expiresIn = "expires_in"
           case user
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
// MARK: - User
struct User: Codable {
    let id: Int?
    let role, name: String?
    let countryCode: String?
    let mobile, email: String?
    let profile, loginType, googleID, appleID: String?
    let status, isNotification: Int?
    let emailVerifiedAt, deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, role, name
        case countryCode = "country_code"
        case mobile, email, profile
        case loginType = "login_type"
        case googleID = "google_id"
        case appleID = "apple_id"
        case status
        case isNotification = "is_notification"
        case emailVerifiedAt = "email_verified_at"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
