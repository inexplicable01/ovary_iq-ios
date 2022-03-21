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
    class func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
