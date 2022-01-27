//
//  UserPhoto.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//
//  UserPhoto.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 11/12/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit

struct UserPhoto: Decodable {
    var orderId: Int = 0
    var id: String = ""
    var url: String?
    var thumbUrl: String?
    var photo: UIImage? = nil

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url = "url"
        case thumbUrl = "thumbUrl"
    }
}
