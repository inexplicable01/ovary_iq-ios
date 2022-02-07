//
//  AuthVerificationCodeDataModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
// MARK: - WelcomeData
struct AuthVerificationDataModel: Codable {
    let message: String?
    let data: VerificationDataModel?
}

// MARK: - DataData
struct VerificationDataModel: Codable {
    let email, token, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case email, token
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       email = try? values.decodeIfPresent(String.self, forKey: .email) ?? ""
       token = try? values.decodeIfPresent(String.self, forKey: .token) ?? ""
       createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
       updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""

   }
}
