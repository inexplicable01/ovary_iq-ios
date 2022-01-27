//
//  UserResponseModel.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
struct UserResponseModel<T: Codable>: Codable {
   // let success: Int?
    let status: String?
    let message: String?
    var genericModel: T?
    enum CodingKeys: String, CodingKey {
      //  case success
        case status = "status"
        case message = "message"
        case genericModel = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    //    success = try? values.decodeIfPresent(Int.self, forKey: .success) ?? 0
        status = try? values.decodeIfPresent(String.self, forKey: .status) ?? ""
        message = try? values.decodeIfPresent(String.self, forKey: .message) ?? "0"
        genericModel = try? values.decodeIfPresent(T.self, forKey: .genericModel)
    }

}
// struct DefaultModel: Codable {
//    let status: Int?
//    let message: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case message = "msg"
// }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//    }
// }
