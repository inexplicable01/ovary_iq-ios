//
//  Venue.swift
//  OvaryIQ
//
//  Created by Mobcoder on 27/01/22.
//
//  Venue.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 25/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation

struct Venue: Decodable {
    var id: String = ""
    var userId: String = ""
    var businessName: String = ""
    var publicBusinessName: String = ""
    var registrationNumber: String = ""
    var businessTypes: [String]? // Array Of Comma Separated Business Types
    var businessHours: [BusinessHour]?
    var businessEntertainments: [String]? // Array Of Comma Separated Entertainments
    var city: String?
    var state: String?
    var country: String?
    var zipCode: Int?
    var address: String?
    var geoLocation: [Double] = [0.0, 0.0]
    var photos: [UserPhoto] = [UserPhoto]()
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "userId"
        case businessName = "businessName"
        case publicBusinessName = "publicBusinessName"
        case registrationNumber = "vat"
        case businessTypes = "venues"
        case businessHours = "openingHours"
        case businessEntertainments = "entertainments"
        case city = "city"
        case state = "state"
        case country = "country"
        case zipCode = "zipCode"
        case address = "address"
        case geoLocation = "geoLocation"
        case photos = "profileCoverPhotos"
    }
}
