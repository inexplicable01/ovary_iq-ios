//
//  changePasswordRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/02/22.
//

import Foundation
struct ChangePasswordRequestModel: Codable {
    var password: String = ""
    var confirmPassword: String = ""
    var currentPassword: String = ""

    enum CodingKeys: String, CodingKey {
        case password = "password"
        case confirmPassword = "confirm_password"
        case currentPassword = "current_password"
    }
}
