//
//  AppConfig.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
class AppConfig: NSObject {

    struct WebUrl {
        static let TermsCondition   = "https://www.google.com/"
        static let TermsOfService   = "https://www.google.com/"
        static let PrivacyPolicy    = "https://www.google.com/"
        static let AboutUs          = "https://www.google.com/"
        static let ContactUs        = "https://www.google.com/"
    }

    struct SocialUrl {
        static let Facebook         = ""
        static let Twitter          = ""
        static let Instagram        = ""
    }

    enum AppCustomConfig: String {
        case appName = "APP_NAME"
        case bundleId = "BUNDLE_ID"
        case appStoreId = "APP_STORE_ID"
        case apiBaseUrl = "API_BASE_URL"
        case socketBaseUrl = "SOCKET_BASE_URL"
        case cdnUrl = "CDN_URL"
        case authUserName = "AUTH_USERNAME"
        case authPassword = "AUTH_PASSWORD"
        case termsOfServices = "TERMS_OF_SERVICE"
        case privacyPolciy = "PRIVACY_POLICY"
        case aboutUs = "ABOUT_US"
        case contactUs = "CONTACT_US"
        case safetyTips = "SAFETY_TIPS"
        case guidelines = "GUIDELINES"
        case safetyCenter = "SAFETY_CENTER"
    }

    static func getAppName() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.appName.rawValue)
        return bundle as? String ?? ""
    }

    static func getBundleId() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.bundleId.rawValue)
        return bundle as? String ?? ""
    }

    static func getAppStoreId() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.appStoreId.rawValue)
        return bundle as? String ?? ""
    }

    static func getAPIBaseURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.apiBaseUrl.rawValue)
        return bundle as? String ?? ""
    }

    static func getSocketBaseURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.socketBaseUrl.rawValue)
        return bundle as? String ?? ""
    }

    static func getCdnURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.cdnUrl.rawValue)
        return bundle as? String ?? ""
    }

    static func getAuthUsername() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.authUserName.rawValue)
        return bundle as? String ?? ""
    }

    static func getAuthPassword() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.authPassword.rawValue)
        return bundle as? String ?? ""
    }

    static func getTermsOfServiceURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.termsOfServices.rawValue)
        return bundle as? String ?? ""
    }

    static func getPrivacyPolicyURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.privacyPolciy.rawValue)
        return bundle as? String ?? ""
    }

    static func getAboutUsURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.aboutUs.rawValue)
        return bundle as? String ?? ""
    }

    static func getContactUsURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.contactUs.rawValue)
        return bundle as? String ?? ""
    }

    static func getSafetyTipsURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.safetyTips.rawValue)
        return bundle as? String ?? ""
    }

    static func getGuidelinesURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.guidelines.rawValue)
        return bundle as? String ?? ""
    }

    static func getSafetyCenterURL() -> String {
        let bundle = kMainBundle.object(forInfoDictionaryKey: AppCustomConfig.safetyCenter.rawValue)
        return bundle as? String ?? ""
    }
}
