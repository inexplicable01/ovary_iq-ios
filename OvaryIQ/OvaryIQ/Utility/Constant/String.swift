//
//  String+Extension.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import Foundation
import UIKit
enum AlertType: String {
    case success = "SUCCESS"
    case apiFailure = "API_FAILURE"
    case validationFailure = "VALIDATION_FAILURE"
    var title: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    var color: UIColor {
       // return Color.colorPrimary.value

            switch self {
            case .validationFailure:
              return Color.failureValidationColor.value
            case .apiFailure:
              return Color.failureValidationColor.value
            case .success:
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
