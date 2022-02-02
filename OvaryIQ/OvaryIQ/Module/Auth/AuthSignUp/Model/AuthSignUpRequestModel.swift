//
//  AuthSignUpRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 28/01/22.
//

import Foundation
struct AuthSignUpRequestModel: Codable {
    var email: String = ""
    var password: String = ""
    var countryCode: String = "+91"
    var mobile: String = ""
    var name: String = ""
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case countryCode = "country_code"
        case mobile = "mobile"
        case name = "name"
    }
}
