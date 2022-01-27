//
//  Constants+String.swift
//  OvaryIQ
//
//  Created by Mobcoder on 18/01/22.
//

import Foundation

// MARK: - ErrorMessages
enum ErrorMessages: String {
    case codeConversionError = "msg_code_conversion_error"
    case noInternetConnection = "msg_no_internet_connection"
    case timeout = "msg_timeout"
    case apiFail = "msg_api_fail"
    case enableLocationServicesTitle = "msg_enable_location_services_title"
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

enum Text: String {
    case appName = "OvaryIQ"
    case cancel = "txt_cancel"
    case oks = "txt_ok"
    // title message
    case logOut = "Do_you_want_to_logout?"
    case notNow = "txt_not_now"
    case settings = "txt_settings"
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
