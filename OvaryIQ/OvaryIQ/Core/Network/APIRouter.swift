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


    var method: HTTPMethod {

        switch self {
        case .signUp,
                .login, .logOut, .savezGoalsDetails, .forgotPassword, .ResetPassword:
            return .post

        case .fetchGoals,.verifyCode:
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
             .ResetPassword(let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

        case .fetchGoals(let params):

            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        case   .verifyCode(let params):
            if let url = urlRequest.url,
               let code = params["code"] as? Double {
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
