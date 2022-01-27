//
//  String+Extension.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import Foundation
import UIKit
enum AlertToastType: String {
    case successAlert = "SUCCESS"
    case apiFailureAlert = "API_FAILURE"
    case validationFailureAlert = "VALIDATION_FAILURE"
    var title: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    var color: UIColor {
       // return Color.colorPrimary.value

            switch self {
            case .validationFailureAlert:
              return Color.failureValidationColor.value
            case .apiFailureAlert:
              return Color.failureValidationColor.value
            case .successAlert:
              return Color.successColor.value
            }
    }
}

enum Color: String {
//    case colorLightPrimary = "colorLightPrimary"
//    case placeholderGray = "colorPlaceholder"
//    case colorPrimary = "colorPrimary"
//    case colorText = "colorText"
//    case bottomLineColor = "colorTextFieldBottomLine"
    case failureValidationColor = "RedColor"
     case successColor = "GreenColor"
    var value: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
}
// MARK: - DefaultKeys
enum DefaultKeys: String {
     case deviceToken = "deviceToken"
     var instance: String {
    return self.rawValue

    }
}
