//
//  AuthVerificationCodeRequestModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/02/22.
//

import Foundation
struct AuthVerificationCodeRequestModel: Codable {
    var otp: Int?
    enum CodingKeys: String, CodingKey {
        case otp = "code"
    }
}
