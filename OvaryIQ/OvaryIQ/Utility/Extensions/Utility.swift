//
//  Utility.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import Foundation
class Utility: NSObject {}
extension Utility {
    class func numberConversion(number: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        guard let finalVerificationCode = formatter.number(from: number) as? Int else {
            Toast.shared.showAlert(type: .apiFailure, message: ErrorMessages.codeConversionError.localizedString)

            return ""
        }

        return "\(finalVerificationCode)"
    }
}
