//
//  AuthSignUpRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 28/01/22.
//

import Foundation
struct ResetPasswordRequestModel: Codable {
    var newPassword: String = ""
    var confirmPassword: String = ""
    var otpCode: String?

    enum CodingKeys: String, CodingKey {
        case newPassword = "New_Password"
        case confirmPassword = "Confirm_Password"
        case otpCode = "code"
    }
}

