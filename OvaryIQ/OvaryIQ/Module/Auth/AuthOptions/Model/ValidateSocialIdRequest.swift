//
//  ValidateSocialIdRequest.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
struct ValidateSocialIdRequest: Codable {
   // var deviceToken: String = kUserDefaults.deviceToken
    var loginType: Int = LoginType.apple.rawValue
    var socialId: String = ""

    enum CodingKeys: String, CodingKey {
       // case deviceToken = "deviceToken"
        case loginType = "socialType"
        case socialId = "socialId"
  }
}
