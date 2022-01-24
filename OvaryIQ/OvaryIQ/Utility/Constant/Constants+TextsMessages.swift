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
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
