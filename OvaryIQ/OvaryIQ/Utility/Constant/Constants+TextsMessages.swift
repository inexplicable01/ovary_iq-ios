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
    // Validation Messages
    case emptyName = "msg_empty_name"
    case emptyPhoneNumber = "msg_empty_phoneNumber"
    case emptyEmail = "msg_empty_email"
    case emptyPassword = "msg_empty_password"
    case emptyConfirmPassword = "msg_empty_confirmPassword"
    case somethingWentWrong = "msg_something_went_wrong"
    case invalidEmailId = "msg_invalid_emailId"
    case selectPeriodCycle = "msg_period_cycle"
    case invalidPassword = "msg_inavild_Password"
    case emptyLastThirdPeriod = "msg_empty_LastThirdPeriod"
    case emptyLastSecondPeriod = "msg_empty_LastSecondPeriod"
    case empptyLastPeriod = "msg_empty_LastPeriod"
    case empptyVerificationCode = "msg_empty_Otp"
    case passwordDoesNotMatch = "msg_password_doesnot_match"
    case otpcodeExipred = "msg_expire_otpCode"
    case logYourBirth = "msg_select_birthLog"
    case selectPeriodStartDate = "msg_select_periodSelectDate"
    case emptyCurrentPassword = "msg_empty_currentPassword"
    case emptyNewPassword = "msg_empty_newPassword"
    case canNotPredictPeriod = "Sorry! we can't predict your period cycle because your periods are very irregular. Please consult a doctor."
    case emptySelectPeriodSubType = "msg_select_period_subType"
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
// MARK: - text
enum Text: String {
    case appName = "OvaryIQ"
    // btn text
    case cancel = "txt_cancel"
    case oks = "txt_ok"
    case backToLogIn = "Back_to_Log_In"
    // title message
    case logOut = "Do_you_want_to_logout?"
    case notNow = "txt_not_now"
    case settings = "txt_settings"
    case myProfile = "txt_myProfile"

    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}


