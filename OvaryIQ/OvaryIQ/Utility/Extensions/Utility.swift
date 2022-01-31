//
//  Utility.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import Foundation
import CoreTelephony
import UIKit

class Utility: NSObject {}

// MARK: - Debug

extension Utility {
    class func isDebug() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    class func isRelease() -> Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }

    class func isSimulatorRunning() -> Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    class func isDevice() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }
}

// MARK: - String

extension Utility {
    class func toString(value: Any?) -> String {
        if let str = value as? String {
            if str == "<null>" || str == "<NULL>" {
                return ""
            } else if str == "<nil>" || str == "<NIL>" {
                return ""
            } else if str == "null" || str == "NULL" {
                return ""
            } else if str == "NIL" || str == "nil" {
                return ""
            } else if str == "(null)" {
                return ""
            }
            return str
        } else if let num = value as? NSNumber {
            return String(format: "%@", num)
        } else if let isBool = value as? Bool {
            return isBool == true ? "1" : "0"
        }
        return ""
    }
}

// MARK: - UIViewController

extension Utility {
    class func rootViewController() -> UIViewController? {
        // return (UIApplication.shared.keyWindow?.rootViewController)
        return (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController)
    }

    class func topMostViewController(rootViewController: UIViewController?) -> UIViewController? {
        if rootViewController == nil {
            return nil
        }

        if let navigationController = rootViewController as? UINavigationController {
            return topMostViewController(rootViewController: navigationController.visibleViewController!)
        }

        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedTabBarController = tabBarController.selectedViewController {
                return topMostViewController(rootViewController: selectedTabBarController)
            }
        }

        if let presentedViewController = rootViewController!.presentedViewController {
            return topMostViewController(rootViewController: presentedViewController)
        }

        return rootViewController
    }
}

// MARK: - UIAlertController

extension Utility {
    class func showOkAlert(title: String, message: String) {
        if let topViewController = Utility.topMostViewController(rootViewController: Utility.rootViewController()) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: Text.oks.localizedString, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            topViewController.present(alertController, animated: true, completion: nil)
        } else {
            dLog(message: "Utility :: showOkAlert :: Unable to get Top Most View Controller")
        }
    }
}

// MARK: - Conversion

extension Utility {
    class func dictToData(dict: [String: Any]) -> Data? {
        if let objectData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            return objectData
        }

        return nil
    }

    class func toJsonString(from object: Any) -> String? {
           if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
               let objectString = String(data: objectData, encoding: .utf8)
               return objectString
           }
           return nil
       }

    class func toBool(_ object: Any?) -> Bool {
           if let obj = object as? NSObject {
               let string = NSString(format: "%@", obj)
               return string.boolValue
           }
           return false
       }

       class func toInt(_ object: Any?) -> Int {
           if let obj = object as? NSObject {
               let string = String(format: "%@", obj)
               return Int(string) ?? 0
           }
           return 0
       }

       class func toInt64(_ object: Any?) -> Int64 {
           if let obj = object as? NSObject {
               let string = String(format: "%@", obj)
               return Int64(string) ?? 0
           }
           return 0
       }

       class func toDouble(_ object: Any?) -> Double {
           if let obj = object as? NSObject {
               let string = String(format: "%@", obj)
               return Double(string) ?? 0.0
           }
           return 0.0
       }

       class func toFloat(_ object: Any?) -> Float {
           if let obj = object as? NSObject {
               let string = String(format: "%@", obj)
               let floatValue = Float(string)
               let twoDecimalPlaces = String(format: "%.4f", floatValue ?? 0)
               return Float(twoDecimalPlaces) ?? 0.0
           }
           return 0.0
       }
}

// MARK: - URL

extension Utility {
    class func canOpenUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }

    class func openUrlInSafari(using urlString: String) {
        var validUrl = urlString
        if !urlString.isEmpty {
            if !(urlString.hasPrefix("http://") || urlString.hasPrefix("https://")) {
                validUrl = "https://" + validUrl
            }
        }
        guard let url = URL(string: validUrl) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: - Toast
/*
/// [Toast](https://github.com/scalessec/Toast-Swift)
/// Uncomment the below extension and add "Toast" library through SPM if you want to show toasts like Android.
extension Utility {
    class func showToast(message: String) {
         if let topViewController = Utility.topMostViewController(rootViewController: Utility.rootViewController()) {
             if message.count > 0 {
                topViewController.view.hideAllToasts()
                topViewController.view.makeToast(message, duration: 3.0, position: .center)
             }
         } else {
            dLog(message: "Utility :: showToast :: Unable to get Top Most View Controller")
         }
     }
}
*/

// MARK: - Array

extension Utility {
    class func sortArray(array: [[String: Any]], byKey key: String, ascending: Bool) -> [[String: Any]] {
        let result = array.sorted {
            switch ($0[key], $1[key]) {
            case (nil, nil), (_, nil):
                return true
            case (nil, _):
                return false
            case let (lhs as String, rhs as String):
                let leftValue = Float(lhs)
                let rightValue = Float(rhs)
                return ascending ? (leftValue! < rightValue!) : (leftValue! > rightValue!)
            case let (lhs as Int, rhs as Int):
                return ascending ? (lhs < rhs) : (lhs > rhs)
            case let (lhs as Float, rhs as Float):
                return ascending ? (lhs < rhs) : (lhs > rhs)
            default:
                return true
            }
        }
        return result
    }
}

// MARK: - Data

extension Utility {
    class func dataToJsonDict(_ data: Data?) -> Any? {
        if data != nil {
            var error: NSError?
            let json: Any?
            do {
                json = try JSONSerialization.jsonObject(
                    with: data!,
                    options: JSONSerialization.ReadingOptions.allowFragments)
            } catch let error1 as NSError {
                error = error1
                json = nil
            }

            // --- *** ---//
            if error != nil {
                return nil
            } else {
                return json
            }
        } else {
            return nil
        }
    }

    class func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }

    class func arrayToString(json: [[String: Any]]) -> String {
        if let data = Utility.jsonToData(json: json) {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return String(decoding: jsonData, as: UTF8.self)
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
}

// MARK: - Font

extension Utility {
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}

// MARK: - Permissions Related

extension Utility {
    class func isPushServiceEnable() -> Bool {
        if #available(iOS 10.0, *) {
            var currentStatus = false
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    currentStatus = true

                case .denied:
                    currentStatus = false

                case .notDetermined:
                    currentStatus = false

                case .provisional:
                    currentStatus = true

                case .ephemeral:
                    currentStatus = true

                @unknown default:
                    currentStatus = false
                }
            }
            return currentStatus
        } else if let settings = UIApplication.shared.currentUserNotificationSettings {
            if settings.types != UIUserNotificationType() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    @discardableResult
//    class func isLocationServiceEnable() -> Bool {
////        if CLLocationManager.locationServicesEnabled() {
////            let locationManager = CLLocationManager()
////            let authorizationStatus: CLAuthorizationStatus
////
////            if #available(iOS 14, *) {
////                authorizationStatus = locationManager.authorizationStatus
////            } else {
////                authorizationStatus = CLLocationManager.authorizationStatus()
////            }
////
////            if authorizationStatus == .notDetermined ||
////                authorizationStatus == .restricted ||
////                authorizationStatus == .denied {
////                return false
////            } else if authorizationStatus == .authorizedAlways ||
////                        authorizationStatus == .authorizedWhenInUse {
////                return true
////            }
////        } else {
//          //  return false
//       // }
//
//        return false
//    }

//    class func checkLocationServiceStatusAndEnableLocationServices(completionClosure: @escaping (_ isLocationServiceEnabled: Bool) -> Void) {
//
//        if CLLocationManager.locationServicesEnabled() {
//
//            let locationManager = CLLocationManager()
//            let authorizationStatus: CLAuthorizationStatus
//
//            if #available(iOS 14, *) {
//                authorizationStatus = locationManager.authorizationStatus
//            } else {
//                authorizationStatus = CLLocationManager.authorizationStatus()
//            }
//
//            if authorizationStatus == .notDetermined {
//                dLog(message: "Location Services Not Determined")
//                SwiftLocation.preferredAuthorizationMode = .plist
//                SwiftLocation.requestAuthorization(.plist) { newStatus in
//                    dLog(message: "Location Services New status \(newStatus.description)")
//
//                    switch newStatus {
//                    case .notDetermined:
//                        dLog(message: "Location Services Not Determined")
//                        completionClosure(false)
//
//                    case .restricted:
//                        dLog(message: "Location Services Restricted")
//                        completionClosure(false)
//
//                    case .denied:
//                        dLog(message: "Location Services Denied")
//                        completionClosure(false)
//
//                    case .authorizedAlways:
//                        dLog(message: "Location Services Enabled")
//                        completionClosure(true)
//
//                    case .authorizedWhenInUse:
//                        dLog(message: "Location Services Enabled")
//                        completionClosure(true)
//
//                    case .authorized:
//                        dLog(message: "Location Services Enabled")
//                        completionClosure(true)
//
//                    @unknown default:
//                        dLog(message: "Location Services Unknown Error")
//                        completionClosure(false)
//                    }
//                }
//
//            } else if authorizationStatus == .restricted {
//                dLog(message: "Location Services Restricted")
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                    Utility.showAlertToAskForOpenSettings(title: Message.enableLocationServicesTitle.localized, message: String(format: Message.enableLocationServicesMessage.localized, AppConfig.getAppName()))
//                })
//
//                completionClosure(false)
//
//            } else if authorizationStatus == .denied {
//                dLog(message: "Location Services Denied")
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                    Utility.showAlertToAskForOpenSettings(title: Message.enableLocationServicesTitle.localized, message: String(format: Message.enableLocationServicesMessage.localized, AppConfig.getAppName()))
//                })
//
//                completionClosure(false)
//
//            } else if authorizationStatus == .authorizedAlways ||
//                        authorizationStatus == .authorizedWhenInUse {
//                dLog(message: "Location Services Enabled")
//                completionClosure(true)
//            }
//        } else {
//            dLog(message: "Location Services Not Enable")
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                Utility.showAlertToAskForOpenSettings(title: ErrorMessages.enableLocationServicesTitle.localized, message: String(format: Message.enableLocationServicesMessage.localized, AppConfig.getAppName()))
//            })
//
//            completionClosure(false)
//
//        }
//    }

//    class func isCameraServiceEnable() -> Bool {
//        var isServiceEnable = false
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//            switch authStatus {
//            case .authorized:
//                isServiceEnable = true
//
//            case .denied:
//                isServiceEnable = false
//
//            case .notDetermined:
//                isServiceEnable = false
//
//            default:
//                isServiceEnable = false
//            }
//        } else {
//            isServiceEnable = false
//        }
//
//        return isServiceEnable
//    }

//    class func isPhotoServiceEnable() -> Bool {
//        var isServiceEnable = false
//        let authStatus = PHPhotoLibrary.authorizationStatus()
//        switch authStatus {
//        case .authorized:
//            isServiceEnable = true
//
//        case .denied:
//            isServiceEnable = false
//
//        case .notDetermined:
//            isServiceEnable = false
//
//        default:
//            isServiceEnable = false
//        }
//        return isServiceEnable
//    }

    class func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }

    class func showAlertToAskForOpenSettings(title: String, message: String) {
        if let topViewController = Utility.topMostViewController(rootViewController: Utility.rootViewController()) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: Text.notNow.localizedString, style: .default) { _ -> Void in
            }

            alertController.addAction(cancel)
            let action = UIAlertAction(title: Text.settings.localizedString, style: .default) { _ -> Void in
                Utility.openSettings()
            }

            alertController.addAction(action)
            topViewController.present(alertController, animated: true, completion: nil)
        } else {
            dLog(message: "Unable to get Top Most View Controller")
        }
    }

//    class func showAlertForCameraAccess(completionClosure: @escaping (_ success: Bool) -> Void) {
//        AVCaptureDevice.requestAccess(for: AVMediaType.video) { status in
//            if status {
//                let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//                switch authStatus {
//                case .authorized:
//                    completionClosure(true)
//
//                case .denied:
//                    completionClosure(false)
//
//                case .notDetermined:
//                    completionClosure(false)
//
//                default:
//                    completionClosure(false)
//                }
//            } else {
//                completionClosure(false)
//            }
//        }
//    }

//    class func showAlertForPhotoAccess(completionClosure: @escaping (_ success: Bool) -> Void) {
//        PHPhotoLibrary.requestAuthorization { status in
//            switch status {
//            case PHAuthorizationStatus.authorized:
//                completionClosure(true)
//
//            case PHAuthorizationStatus.denied:
//                completionClosure(false)
//
//            case PHAuthorizationStatus.restricted:
//                completionClosure(false)
//
//            default:
//                completionClosure(false)
//            }
//        }
//    }
}

// MARK: - Encode & Decode

//extension Utility {
//    class func decode(_ str: String) -> String? {
//        let data = str.data(using: .utf8)!
//        return String(data: data, encoding: .nonLossyASCII)
//    }
//
//    class func encode(_ str: String) -> String {
//        let data = str.data(using: .nonLossyASCII, allowLossyConversion: true)!
//        return String(data: data, encoding: .utf8)!
//    }
//
//    class func encodeEmoji(_ str: String) -> String {
//        let data = str.data(using: .nonLossyASCII, allowLossyConversion: true)!
//        return String(data: data, encoding: .utf8)!
//    }
//
//    class func decodeEmoji(_ str: String) -> String? {
//        let data = str.data(using: .utf8)!
//        return String(data: data, encoding: .nonLossyASCII)
//    }
//}

// MARK: - Starify

extension Utility {
    class func starifyPhoneNumber(number: String) -> String {
        if number.isEmpty {
            return ""
        }

        let initialLetters = number.prefix(1)
        let endLetters = number.suffix(1)
        let numberOfStars = number.count - (initialLetters.count + endLetters.count)
        let stars = String(repeating: "*", count: numberOfStars)
        let finalNumberToShow: String = initialLetters + stars + endLetters
        return finalNumberToShow
    }

    class func starifyEmailAddress(email: String) -> String {
        if email.isEmpty {
            return ""
        }

        let delimiter = "@"
        let arrayEmail = email.components(separatedBy: "@")
        let firstPart = arrayEmail[0]
        let secondPart = arrayEmail[1]

        let initialLettersFirstPart = firstPart.prefix(1)
        let endLettersFirstPart = firstPart.suffix(1)
        let numberOfStarsFirstPart = firstPart.count - (initialLettersFirstPart.count + endLettersFirstPart.count)
        let starsFirstPart = String(repeating: "*", count: numberOfStarsFirstPart)
        let finalFirstPart: String = initialLettersFirstPart + starsFirstPart + endLettersFirstPart

        let initialLettersSecondPart = secondPart.prefix(1)
        let endLettersSecondPart = secondPart.suffix(2)
        let numberOfStarsSecondPart = secondPart.count - (initialLettersSecondPart.count + endLettersSecondPart.count)
        let starsSecondPart = String(repeating: "*", count: numberOfStarsSecondPart)
        let finalSecondPart: String = initialLettersSecondPart + starsSecondPart + endLettersSecondPart

        return finalFirstPart + delimiter + finalSecondPart
    }
}

extension Utility {
    class func numberConversion(number: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        guard let finalVerificationCode = formatter.number(from: number) as? Int else {
            AlertControllerManager.showToast(message: ErrorMessages.codeConversionError.localizedString, type: AlertType.error)
            return ""
        }

        return "\(finalVerificationCode)"
    }
}

extension Utility {

    class func isSimAvailable() -> Bool {
        let info = CTTelephonyNetworkInfo()
        let carr = info.subscriberCellularProvider
        guard let carrier = carr else {
            return false
        }

        guard let carrierCode = carrier.mobileNetworkCode else {
            return false
        }

        guard carrierCode != "" else {
            return false
        }
        return true
    }

    class func getCountryCallingCode() -> String {

        let telephony = CTTelephonyNetworkInfo()
        var carrier: CTCarrier? = nil
        if #available(iOS 12.0, *) {
            carrier = telephony.serviceSubscriberCellularProviders?.first?.value
        } else {
            carrier = telephony.subscriberCellularProvider
        }

        dLog(message: "Carrier :: \(String(describing: carrier))")

        guard let carrier = carrier, let countryCode = carrier.isoCountryCode else { return "+1" }
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryCode.uppercased()] ?? "+1"
        return "+" + countryDialingCode
    }

    class func getCountryRegion() -> String {
        let telephony = CTTelephonyNetworkInfo()
        var carrier: CTCarrier? = nil
        if #available(iOS 12.0, *) {
            carrier = telephony.serviceSubscriberCellularProviders?.first?.value
        } else {
            carrier = telephony.subscriberCellularProvider
        }
        guard let carrier = carrier, let countryCode = carrier.isoCountryCode else { return "US" }
        return countryCode.uppercased()
    }

    class func getCountryFlag() -> UIImage? {
        return UIImage(named: "Countries.bundle/Images/\(Utility.getCountryRegion())")
    }
}

extension Utility {

//    class func getLatAndLongFromLocation(location: String, completionClosure: @escaping (_ latitude: Double, _ longitude: Double, _ location: String) -> Void) {
//
//        if !location.isEmpty {
//            let service = Geocoder.Apple(address: location)
//            SwiftLocation.geocodeWith(service).then { result in
//
//                // Different services, same expected output [GeoLocation]
//                dLog(message: "Places Data :: \(String(describing: result.data))")
//
//                if let coordinate: CLLocationCoordinate2D = result.data?[0].coordinates {
//                    completionClosure(coordinate.latitude.rounded(toPlaces: kLatLongRoundPlace), coordinate.longitude.rounded(toPlaces: kLatLongRoundPlace), location)
//                } else {
//                    completionClosure(0.0, 0.0, location)
//                }
//            }
//        } else {
//            completionClosure(0.0, 0.0, location)
//        }
//    }

//    class func getUserLocationFromCoordinate(coordinate: CLLocationCoordinate2D, completionClosure: @escaping (_ latitude: Double, _ longitude: Double, _ location: String) -> Void) {
//
//        let service = Geocoder.Apple(coordinates: coordinate)
//        SwiftLocation.geocodeWith(service).then { result in
//
//            // Different services, same expected output [GeoLocation]
//            dLog(message: "Places Data :: \(String(describing: result.data))")
//
//            var locationL = ""
//            if let palcesData = result.data {
//                if !palcesData.isEmpty {
//                    // locationL = (palcesData[0].info[.formattedAddress] ?? "") ?? ""
//
//                    let name = (palcesData[0].info[.name] ?? "") ?? ""
//                    let subLocality = (palcesData[0].info[.subLocality] ?? "") ?? ""
//                    let locality = (palcesData[0].info[.locality] ?? "") ?? ""
//                    let subAdministrativeArea = (palcesData[0].info[.subAdministrativeArea] ?? "") ?? ""
//                    let administrativeArea = (palcesData[0].info[.administrativeArea] ?? "") ?? ""
//                    let country = (palcesData[0].info[.country] ?? "") ?? ""
//                    let postalCode = (palcesData[0].info[.postalCode] ?? "") ?? ""
//
//                    if !name.isEmpty {
//                        locationL += name + ", "
//                    }
//
//                    if !subLocality.isEmpty && subLocality != name {
//                        locationL += subLocality + ", "
//                    }
//
//                    if !locality.isEmpty {
//                        locationL += locality + ", "
//                    }
//
//                    if !subAdministrativeArea.isEmpty && subAdministrativeArea != locality {
//                        locationL += subAdministrativeArea + ", "
//                    }
//
//                    if !administrativeArea.isEmpty {
//                        locationL += administrativeArea + ", "
//                    }
//
//                    if !country.isEmpty {
//                        locationL += country + ", "
//                    }
//
//                    if !postalCode.isEmpty {
//                        locationL += postalCode
//                    }
//
//                }
//            }
//
//            completionClosure(coordinate.latitude.rounded(toPlaces: kLatLongRoundPlace), coordinate.longitude.rounded(toPlaces: kLatLongRoundPlace), locationL)
//        }
//    }

//    class func getUserCurrentLatitudeAndLongitudeWithLocation(completionClosure: @escaping (_ latitude: Double, _ longitude: Double, _ location: String) -> Void) {
//
//        SwiftLocation.gpsLocationWith {
//            $0.precise = .fullAccuracy
//            $0.subscription = .single
//            $0.accuracy = .house
//            $0.activityType = .automotiveNavigation
//            $0.timeout = .delayed(5) // 5 seconds of timeout after auth granted
//        }.then { result in // you can attach one or more subscriptions via `then`.
//            switch result {
//            case .success(let location):
//
//                dLog(message: "Location Received Success :: \(location)")
//
//                let service = Geocoder.Apple(coordinates: location.coordinate)
//                SwiftLocation.geocodeWith(service).then { result in
//
//                    // Different services, same expected output [GeoLocation]
//                    dLog(message: "Places Data :: \(String(describing: result.data))")
//
//                    var locationL = ""
//                    if let palcesData = result.data {
//                        if !palcesData.isEmpty {
//                            // locationL = (palcesData[0].info[.formattedAddress] ?? "") ?? ""
//
//                            let name = (palcesData[0].info[.name] ?? "") ?? ""
//                            let subLocality = (palcesData[0].info[.subLocality] ?? "") ?? ""
//                            let locality = (palcesData[0].info[.locality] ?? "") ?? ""
//                            let subAdministrativeArea = (palcesData[0].info[.subAdministrativeArea] ?? "") ?? ""
//                            let administrativeArea = (palcesData[0].info[.administrativeArea] ?? "") ?? ""
//                            let country = (palcesData[0].info[.country] ?? "") ?? ""
//                            let postalCode = (palcesData[0].info[.postalCode] ?? "") ?? ""
//
//                            if !name.isEmpty {
//                                locationL += name + ", "
//                            }
//
//                            if !subLocality.isEmpty && subLocality != name {
//                                locationL += subLocality + ", "
//                            }
//
//                            if !locality.isEmpty {
//                                locationL += locality + ", "
//                            }
//
//                            if !subAdministrativeArea.isEmpty && subAdministrativeArea != locality {
//                                locationL += subAdministrativeArea + ", "
//                            }
//
//                            if !administrativeArea.isEmpty {
//                                locationL += administrativeArea + ", "
//                            }
//
//                            if !country.isEmpty {
//                                locationL += country + ", "
//                            }
//
//                            if !postalCode.isEmpty {
//                                locationL += postalCode
//                            }
//
//                        }
//                    }
//
//                    completionClosure(location.coordinate.latitude.rounded(toPlaces: kLatLongRoundPlace), location.coordinate.longitude.rounded(toPlaces: kLatLongRoundPlace), locationL)
//                }
//
//            case .failure(let error):
//
//                dLog(message: "Location Received Error :: \(error.localizedDescription)")
//
//                if kUserDefaults.isUserLogin {
//                    let oldLatitude = kUserDefaults.userLatitude
//                    let oldLongitude = kUserDefaults.userLongitude
//                    let oldLocation = kUserDefaults.userLocation
//
//                    completionClosure(oldLatitude, oldLongitude, oldLocation)
//                } else {
//                    completionClosure(0.0, 0.0, "")
//                }
//
//            }
//        }
//    }

//    class func getUserCurrentLocationInfo(completionClosure: @escaping (_ googlePlace: GooglePlace?) -> Void) {
//
//        SwiftLocation.gpsLocationWith {
//            $0.precise = .fullAccuracy
//            $0.subscription = .single
//            $0.accuracy = .house
//            $0.activityType = .automotiveNavigation
//            $0.timeout = .delayed(5) // 5 seconds of timeout after auth granted
//        }.then { result in // you can attach one or more subscriptions via `then`.
//            switch result {
//            case .success(let location):
//
//                dLog(message: "Location Received Success :: \(location)")
//
//                var googlePlace: GooglePlace? = nil
//
//                let service = Geocoder.Apple(coordinates: location.coordinate)
//                SwiftLocation.geocodeWith(service).then { result in
//
//                    // Different services, same expected output [GeoLocation]
//                    dLog(message: "Places Data :: \(String(describing: result.data))")
//
//                    /*
//                     [{
//                         coordinates = lat:28.600077,lng:77.372199,
//                         name=Optional("Major Anurag Nauriyal Marg")
//                         administrativeArea = 'UP'
//                         locality = 'Noida'
//                         subThroughfare = ''
//                         countryCode = 'IN'
//                         formattedAddress = 'Major Anurag Nauriyal Marg
//                     Noida 201307
//                     UP
//                     India'
//                         subAdministrativeArea = 'Gautam Buddha Nagar'
//                         subLocality = 'Sector 61'
//                         throughfare = 'Major Anurag Nauriyal Marg'
//                         country = 'India'
//                         postalCode = '201307'
//                         name = 'Major Anurag Nauriyal Marg'
//                     }]
//                     */
//
//                    var locationL = ""
//                    if let palcesData = result.data {
//                        if !palcesData.isEmpty {
//                            // locationL = (palcesData[0].info[.formattedAddress] ?? "") ?? ""
//
//                            let name = (palcesData[0].info[.name] ?? "") ?? ""
//                            let subLocality = (palcesData[0].info[.subLocality] ?? "") ?? ""
//                            let locality = (palcesData[0].info[.locality] ?? "") ?? ""
//                            let subAdministrativeArea = (palcesData[0].info[.subAdministrativeArea] ?? "") ?? ""
//                            let administrativeArea = (palcesData[0].info[.administrativeArea] ?? "") ?? ""
//                            let country = (palcesData[0].info[.country] ?? "") ?? ""
//                            let postalCode = (palcesData[0].info[.postalCode] ?? "") ?? ""
//
//                            if !name.isEmpty {
//                                locationL += name + ", "
//                            }
//
//                            if !subLocality.isEmpty && subLocality != name {
//                                locationL += subLocality + ", "
//                            }
//
//                            if !locality.isEmpty {
//                                locationL += locality + ", "
//                            }
//
//                            if !subAdministrativeArea.isEmpty && subAdministrativeArea != locality {
//                                locationL += subAdministrativeArea + ", "
//                            }
//
//                            if !administrativeArea.isEmpty {
//                                locationL += administrativeArea + ", "
//                            }
//
//                            if !country.isEmpty {
//                                locationL += country + ", "
//                            }
//
//                            if !postalCode.isEmpty {
//                                locationL += postalCode
//                            }
//
//                            googlePlace = GooglePlace()
//                            googlePlace!.name = name
//                            googlePlace!.city = subAdministrativeArea.isEmpty ? locality : subAdministrativeArea
//                            googlePlace!.state = administrativeArea
//                            googlePlace!.country = country
//                            googlePlace!.pincode = postalCode
//                            googlePlace!.address = locationL
//                            googlePlace!.latitude = location.coordinate.latitude
//                            googlePlace!.longitude = location.coordinate.longitude
//                        }
//                    }
//
//                    completionClosure(googlePlace)
//                }
//
//            case .failure(let error):
//                dLog(message: "Location Received Error :: \(error.localizedDescription)")
//                completionClosure(nil)
//            }
//        }
//    }

    class func uniqueId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "iOS"
    }

//    class func getNearAboutLocationFromLocation(location: CLLocation) -> CLLocation {
//
//        //let cl = CLLocation(latitude: 28.6280, longitude: 77.3649)
//        //Generate random number 500 meter to 2000 meter
//        let randomInt = Int.random(in: 500...2000)
//        let nl = location.movedBy(latitudinalMeters: CLLocationDistance(randomInt), longitudinalMeters: 0)
//        dLog(message: "New Lat Long :: \(nl.coordinate.latitude) :: \(nl.coordinate.longitude)")
//        dLog(message: "Diff :: \(location.distance(from: nl))")
//        return nl
//    }
}

extension Utility {
    class func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
