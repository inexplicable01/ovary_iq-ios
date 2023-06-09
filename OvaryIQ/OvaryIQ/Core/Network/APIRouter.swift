//
//  APIRouter.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {

    case signUp(params: Parameters)
    case login(params: Parameters)
    case logOut(params: Parameters)
    case fetchGoals(params: Parameters)
    case savezGoalsDetails(params: Parameters)
    case forgotPassword(params: Parameters)
    case verifyCode(params: Parameters)
    case ResetPassword(params: Parameters)
    case getDataForLogPeriod(params: Parameters)
    case getUserLogPeriodData(params: Parameters)
    case changePassword(params: Parameters)
    case userProfile(params: Parameters)
    case saveUserMedications(params: Parameters)
    case saveUserProcedures(params: Parameters)
    case saveUserActivities(params: Parameters)
    case saveUserSymptoms(params: Parameters)
    case saveUserPregnancyTests(params: Parameters)
    case saveLogPeriod(params: Parameters)
    case projectionData(params: Parameters)
    case getUsersMedicalOptionsData(params: Parameters)
    case updateProfilePhoto(params: Parameters)


    var method: HTTPMethod {

        switch self {
        case .signUp,
                    .login, .logOut, .savezGoalsDetails, .forgotPassword, .ResetPassword, .saveLogPeriod, .changePassword, .saveUserMedications, .saveUserProcedures, .saveUserActivities, .saveUserSymptoms, .saveUserPregnancyTests, .updateProfilePhoto:
            return .post

            case .fetchGoals,.verifyCode, .getDataForLogPeriod, .getUserLogPeriodData, .userProfile, .projectionData,.getUsersMedicalOptionsData:
            return .get

        }
    }

    var path: String {
        switch self {
        case .signUp: return APIName.SignUp
        case .login: return APIName.Login
        case .logOut: return APIName.LogOut
        case .fetchGoals: return APIName.FetchGoals
        case .savezGoalsDetails: return APIName.SaveGoalsDetails
        case .forgotPassword: return APIName.ForgotPassword
        case .verifyCode: return APIName.VerifyCode
        case .ResetPassword: return APIName.ResetPassword
        case .getDataForLogPeriod: return APIName.getDataForLogPeriod
        case .getUserLogPeriodData: return APIName.getUserLogPeriodData
        case .saveLogPeriod: return APIName.saveLogPeriod
        case .changePassword: return APIName.changePassword
        case .userProfile: return APIName.userProfile
        case .saveUserMedications: return APIName.saveUserMedications
        case .saveUserProcedures: return APIName.saveUserProcedures
        case .saveUserActivities: return APIName.saveUserActivities
        case .saveUserSymptoms: return APIName.saveUserSymptoms
        case .saveUserPregnancyTests: return APIName.saveUserPregnancyTests
        case .projectionData: return APIName.projectionData
        case .getUsersMedicalOptionsData: return APIName.getUsersMedicalOptionsData
        case .updateProfilePhoto:  return APIName.updateProfilePhoto

        }
    }

    //MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        // Make Basic Auth for api authentication
        var headers: [String: String] = [:]
        let authorizationHeader = HTTPHeader.authorization(username: AppConfig.getAuthUsername(), password: AppConfig.getAuthPassword())
        headers["Authorization"] = authorizationHeader.value
        let accessToken = "\(UserDefaults.accessToken)"
        if accessToken.length > 0 {
            headers[APIParam.AccessToken] = accessToken
        }

        var urlRequest = URLRequest(url: try path.asURL())
        urlRequest.httpMethod = method.rawValue
        //urlRequest.headers = headers
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringCacheData

        switch self {
        case .signUp(let params),
             .login(let params),
             .logOut(let params),
             .savezGoalsDetails(let params),
             .forgotPassword(let params),
             .ResetPassword(let params),
             .saveLogPeriod(let params),
             .changePassword(let params),
             .saveUserMedications(let params),
             .saveUserProcedures(let params),
             .saveUserActivities(let params),
             .saveUserSymptoms(let params),
             .saveUserPregnancyTests(let params):
              urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

        case .fetchGoals(let params), .getDataForLogPeriod(let params), .getUserLogPeriodData(let params):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)

            case .projectionData(let params),.updateProfilePhoto(let params):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)


        case .userProfile(let params):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)

        case .getUsersMedicalOptionsData(let params):
               urlRequest = try URLEncoding.default.encode(urlRequest, with: params)


         case .verifyCode(let params):
            if let url = urlRequest.url,
               let code = params["code"] as? Int {
                var urlStr = url.absoluteString
                urlStr += "/" + "\(code)"
                urlRequest.url = URL(string: urlStr)
            }
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }

        dLog(message: "API URL Request :: \(urlRequest)")
        dLog(message: "API Header :: \(headers)")

        return urlRequest
    }
}
