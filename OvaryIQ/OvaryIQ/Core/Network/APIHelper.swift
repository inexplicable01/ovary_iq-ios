//
//  APIHelper.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation

let baseURL = AppConfig.getAPIBaseURL()

// MARK: - Api name
struct APIName {
    static let SignUp =  baseURL + "auth/register"
    static let Login  =  baseURL + "auth/login"
    static let LogOut  =  baseURL + "auth/logout"
    static let FetchGoals  =  baseURL + "auth/fetch_goals"
    static let SaveGoalsDetails  =  baseURL + "auth/save_user_goal_details"
    static let ForgotPassword  =  baseURL + "auth/password/create_password_token"
    static let VerifyCode = baseURL + "auth/password/match_passsword_token"
    static let ResetPassword = baseURL + "auth/password/reset_password"
    static let getDataForLogPeriod = baseURL + "auth/getDataForLogPeriod"
    static let getUserLogPeriodData = baseURL + "auth/getUserLogPeriodData"
    static let changePassword =  baseURL + "auth/change_password"
    static let userProfile =  baseURL + "auth/userProfile"
    static let saveUserMedications =  baseURL + "auth/saveUserMedications"
    static let saveUserProcedures =  baseURL + "auth/saveUserProcedures"
    static let saveUserActivities =  baseURL + "auth/saveUserActivities"
    static let saveUserSymptoms =  baseURL + "auth/saveUserSymptoms"
    static let saveUserPregnancyTests =  baseURL + "auth/saveUserPregnancyTests"
    static let saveLogPeriod = baseURL + "auth/saveLogPeriod"
    static let projectionData = baseURL + "auth/projectionData"
    static let getUsersMedicalOptionsData = baseURL + "auth/getUsersMedicalOptionsData"
    static let updateProfilePhoto = baseURL + "auth/updateProfilePhoto"
}

// MARK: - Parameter keys
struct APIParam  {
    static let Authorization = "Authorization"
    static let AccessToken = "accessToken"

    static let Error = "error"
    static let Errors = "errors"
    static let ErrorCode = "errorCode"
    static let ResponseMessage = "message"
    static let profile = "profile"


    // SAVE USER MEDICATION DATA
    static let id = "id"
    static let date = "date"
    static let MedicationId = "medication_id"
    static let ProcedureId = "procedure_id"
    static let ActivityId = "activity_id"
    static let SymptomId = "symptom_id"
    static let PregnancyTestId = "pregnancy_test_id"




    static let StatusCode = "statusCode"
    static let Data = "data"
    static let Response = "response"
    static let Result = "result"
    static let Message = "message"
    static let Time = "time"

    static let keyName = "keyName"
    static let keyName1 = "keyName1"
    
}
