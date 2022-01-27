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
    static let SignUp = "auth/register"
}

// MARK: - Parameter keys
struct APIParam  {
    static let Authorization = "Authorization"
    static let AccessToken = "accessToken"

    static let Error = "error"
    static let Errors = "errors"
    static let ErrorCode = "errorCode"
    static let ResponseMessage = "responseMessage"


    static let StatusCode = "statusCode"
    static let ResponseData = "responseData"
    static let Response = "response"
    static let Result = "result"
    static let Message = "message"
    static let Time = "time"

    static let keyName = "keyName"
    static let keyName1 = "keyName1"}
