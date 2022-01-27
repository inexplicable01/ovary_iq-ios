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
//    case verifyOtp(params: Parameters)
//    case validateSocialId(params: Parameters)
//    case registration(params: Parameters)
//    case editProfile(params: Parameters)
//    case deleteProfileImage(params: Parameters)
//    case logout(params: Parameters)
//    case getAllVenues(params: Parameters)
//    case userUpdateLocation(params: Parameters)

    var method: HTTPMethod {

        switch self {

//        case .getAllVenues, .logout:
//            return .get

        case .signUp:
            return .post
        }
    }

    var path: String {
        switch self {
        case .signUp: return APIName.SignUp
//        case .verifyOtp: return APIName.VerifyOtp
//        case .validateSocialId: return APIName.ValidateSocialId
//        case .registration: return APIName.Registration
//        case .editProfile: return APIName.EditProfile
//        case .deleteProfileImage: return APIName.DeleteProfileImage
//        case .logout: return APIName.Logout
//        case .getAllVenues: return APIName.GetAllVenues
//        case .userUpdateLocation: return APIName.UserUpdateLocation
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
        case .signUp(let params):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)

            //urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            //urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        }

        dLog(message: "API URL Request :: \(urlRequest)")
        dLog(message: "API Header :: \(headers)")

        return urlRequest
    }
}
