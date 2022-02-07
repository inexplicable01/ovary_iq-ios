
//  AuthSignUpDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.


import Foundation
struct AuthSignUpDataModel: Codable {
    var message, accessToken, tokenType, isSaveGoal: String?
    var expiresIn: Int?
    var user: UserDataModel?

       enum CodingKeys: String, CodingKey {
           case message
           case accessToken = "access_token"
           case tokenType = "token_type"
           case expiresIn = "expires_in"
           case isSaveGoal
           case user
       }

     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try? values.decodeIfPresent(String.self, forKey: .message) ?? ""
        accessToken = try? values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        tokenType = try? values.decodeIfPresent(String.self, forKey: .tokenType) ?? ""
         isSaveGoal = try? values.decodeIfPresent(String.self, forKey: .isSaveGoal) ?? ""
        expiresIn = try? values.decodeIfPresent(Int.self, forKey: .expiresIn) ?? 0
        expiresIn = try? values.decodeIfPresent(Int.self, forKey: .expiresIn) ?? 0
        user = try? values.decodeIfPresent(UserDataModel.self, forKey: .user) ?? nil
    }
}
// MARK: - User
struct UserDataModel: Codable {
   var id: Int?
   var role, name: String?
   var countryCode: String?
   var mobile, email: String?
   var profile, loginType, googleID, appleID: String?
   var status, isNotification: Int?
   var emailVerifiedAt, deletedAt: String?
   var createdAt, updatedAt: String?

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

    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       id = try? values.decodeIfPresent(Int.self, forKey: .id) ?? 0
       role = try? values.decodeIfPresent(String.self, forKey: .role) ?? ""
       name = try? values.decodeIfPresent(String.self, forKey: .name) ?? ""
       countryCode = try? values.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
       mobile = try? values.decodeIfPresent(String.self, forKey: .mobile) ?? ""
       email = try? values.decodeIfPresent(String.self, forKey: .mobile) ?? ""
       profile = try? values.decodeIfPresent(String.self, forKey: .profile) ?? ""
       loginType = try? values.decodeIfPresent(String.self, forKey: .loginType) ?? ""
       googleID = try? values.decodeIfPresent(String.self, forKey: .googleID) ?? ""
       appleID = try? values.decodeIfPresent(String.self, forKey: .appleID) ?? ""
       status = try? values.decodeIfPresent(Int.self, forKey: .status) ?? 0
       isNotification = try? values.decodeIfPresent(Int.self, forKey: .isNotification) ?? 0
       emailVerifiedAt = try? values.decodeIfPresent(String.self, forKey: .emailVerifiedAt) ?? ""
       deletedAt  = try? values.decodeIfPresent(String.self, forKey: .deletedAt) ?? ""
       createdAt  = try? values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
       updatedAt  = try? values.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
   }

}
