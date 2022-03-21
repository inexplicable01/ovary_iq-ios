//
//  ForgotPasswordDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
// MARK: - WelcomeData
struct ForgotPasswordDataModel: Codable {
    let message: String?
    let data: UserDataModel?
    let tokenData: TokenDataModel?

    enum CodingKeys: String, CodingKey {
        case message, data
        case tokenData = "token_data"
    }

    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       message = try? values.decodeIfPresent(String.self, forKey: .message) ?? ""
       data = try? values.decodeIfPresent(UserDataModel.self, forKey: .data)
       tokenData = try? values.decodeIfPresent(TokenDataModel.self, forKey: .tokenData)
   }
}

// MARK: - DataData
//struct DataModel: Codable {
//    let id: Int?
//    let role, name: String?
//    let countryCode: JSONNull?
//    let mobile, email: String?
//    let profile, loginType, googleID, appleID: JSONNull?
//    let status, isNotification: Int?
//    let emailVerifiedAt, deletedAt: JSONNull?
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, role, name
//        case countryCode = "country_code"
//        case mobile, email, profile
//        case loginType = "login_type"
//        case googleID = "google_id"
//        case appleID = "apple_id"
//        case status
//        case isNotification = "is_notification"
//        case emailVerifiedAt = "email_verified_at"
//        case deletedAt = "deleted_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

// MARK: - TokenData
struct TokenDataModel: Codable {
    let email, token, createdAt, updatedAt: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case email, token
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name
    }
    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       email = try? values.decodeIfPresent(String.self, forKey: .email) ?? ""
       token = try? values.decodeIfPresent(String.self, forKey: .token) ?? ""
       name = try? values.decodeIfPresent(String.self, forKey: .name) ?? ""
       createdAt  = try? values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
       updatedAt  = try? values.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
   }
}
