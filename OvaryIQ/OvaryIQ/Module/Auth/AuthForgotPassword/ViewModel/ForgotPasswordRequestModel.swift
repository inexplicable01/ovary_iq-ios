//
//  ForgotPasswordRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
struct ForgotPasswordRequestModel: Codable {
    var email: String = ""
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
