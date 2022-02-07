//
//  String+Extension.swift
//  OvaryIQ
//
//  Created by Mobcoder on 28/01/22.
//

import Foundation
import UIKit
extension String {

    func trim() -> String {
        //return components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    func removeWhiteSpacesAndNewLines() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }

    func removeWhiteSpaces() -> String {
        return self.components(separatedBy: NSCharacterSet.whitespaces).joined(separator: "")
    }

    func isContainsWhiteSpace() -> Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }

    var length: Int {
        return self.count
    }

    func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }

    func encodeUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }

    func decodeUrl() -> String {
        return self.removingPercentEncoding ?? self
    }

    func toLocalizedString() -> String {
        return NSLocalizedString(self, comment: self)
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    func toBase64() -> String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    func toBool() -> Bool {
        let trimmedString = self.trim().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        } else if trimmedString == "1" {
            return true
        }
        return false
    }

    func toUncamelized() -> String {
        let upperCase = CharacterSet.uppercaseLetters
        return self.unicodeScalars.map {
            upperCase.contains($0) ? "_" + String($0).lowercased(): String($0)
            }.joined()
    }

    func isNumeric() -> Bool {
        let hasNumbers = self.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let hasLetters = self.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        return hasNumbers && !hasLetters
    }

//    var isNumberOnly: Bool {
//        guard self.count > 0 else { return false }
//        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//        return Set(self).isSubset(of: nums)
//    }
//
//    func isContainEmoji() -> Bool {
//        let isContain = unicodeScalars.first(where: { $0.isEmoji }) != nil
//        return isContain
//    }

    func isContainSpecialCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            return false
        }

        return false
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return boundingBox.height
    }

    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }

//    func emojiSupportServerSide() -> String {
//        let data =  self.data(using: .nonLossyASCII)
//        let emojiString = String.init(data: data!, encoding: .utf8)
//        return emojiString ?? ""
//    }
//
//    func emojiSupportAppSide() -> String {
//        let data = self.data(using: .utf8)
//        let emoji = String.init(data: data!, encoding: .nonLossyASCII)
//       return emoji ?? ""
//    }

    func stringToDictionary() -> [String: Any] {
        var dictonary: [String: Any]?
        if let data = self.data(using: String.Encoding.utf8) {

            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let myDictionary = dictonary {
                    return myDictionary
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return [:]
    }

    // MARK: - for check valid email format
    func isValidemail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    // MARK: - Password must be between 8 to 16 character,one uppercase,one lowercase and one special character
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,16}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }

    func isAlphabet() -> Bool {
           let regularExpression = "^[a-zA-Z0-9]{8,}$"
           let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
           return passwordValidation.evaluate(with: self)
       }
}
