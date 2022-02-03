//
//  AuthSignUpRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 28/01/22.
//

import Foundation
struct AuthLoginRequestModel: Codable {
    var email: String = ""
    var password: String = ""

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
}

