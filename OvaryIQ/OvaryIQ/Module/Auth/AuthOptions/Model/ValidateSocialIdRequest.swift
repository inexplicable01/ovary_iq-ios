//
//  ValidateSocialIdRequest.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
struct ValidateSocialIdRequest: Codable {
   // var deviceToken: String = kUserDefaults.deviceToken
    var loginType: String = LoginType.apple.rawValue
    var socialId: String = ""
    var email: String = ""
    var name: String = ""
    var profile: String = ""

    enum CodingKeys: String, CodingKey {
       // case deviceToken = "deviceToken"
        case loginType = "login_type"
        case socialId = "media_login_id"
        case name = "name"
        case email = "email"
  }
}
