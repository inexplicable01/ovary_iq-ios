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

    var method: HTTPMethod {

        switch self {
        case .signUp, .login, .logOut, .savezGoalsDetails:
            return .post

        case .fetchGoals:
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
        }
    }

    //MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {

        var headers: [String: String] = [:]
       // let authorizationHeader = HTTPHeader.authorization(username: AppConfig.getAuthUsername(), password: AppConfig.getAuthPassword())
     //   headers["Authorization"] = authorizationHeader.value

        headers["Authorization"] = ""

//        let accessToken = UserDefaults.accessToken
//        if accessToken.length > 0 {
//            headers[APIParam.AccessToken] = accessToken
//        }

        var urlRequest = URLRequest(url: try path.asURL())
        urlRequest.httpMethod = method.rawValue
        //urlRequest.headers = headers
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringCacheData

        switch self {
        case .signUp(let params),
             .login(let params),
             .logOut(let params),
             .fetchGoals(let params),
             .savezGoalsDetails(let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

            //urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            //urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        }

        dLog(message: "API URL Request :: \(urlRequest)")
        dLog(message: "API Header :: \(headers)")

        return urlRequest
    }
}
