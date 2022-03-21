//
//  UserInfo.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 06/12/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit

struct UserInfo: Decodable {
    var userId: String = ""
    var socialId: String?
    var loginType: Int?
    var email: String?
    var countryCallingCode: String?
    var phoneNo: String?
    var firstName: String?
    var lastName: String?
    var dob: Int?
    var gender: Int?
    var city: String?
    var state: String?
    var country: String?
    var address: String?
    var zipCode: Int?
    var geoLocation: [Double]?
    var height: String?
    var ethnicity: String?
    var favouriteVenues: [String]? // Array Of Comma Separated Venues/Business Ids
    var businessName: String?
    var publicBusinessName: String?
    var registrationNumber: String?
    var businessTypes: [String]? // Array Of Comma Separated Business Types
    var businessHours: [BusinessHour]?
    var businessEntertainments: [String]? // Array Of Comma Separated Entertainments
    var photos: [UserPhoto]?

    var isAccessToRewindFeatureEnable: Int?
    var isPushNotificationEnable: Int?
    var isEmailNotificationEnable: Int?
    var isTextNotificationEnable: Int?

    var isUserAccountExist: Int?
    var isBusinessAccountExist: Int?

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case socialId = "socialId"
        case loginType = "socialType"
        case email = "email"
        case countryCallingCode = "countryCode"
        case phoneNo = "mobile"
        case firstName = "firstName"
        case lastName = "lastName"
        case dob = "dob"
        case gender = "gender"
        case city = "city"
        case state = "state"
        case country = "country"
        case address = "address"
        case zipCode = "zipCode"
        case geoLocation = "geoLocation"
        case height = "height"
        case ethnicity = "ethnicity"
        case favouriteVenues = "favouriteVenues"

        case businessName = "businessName"
        case publicBusinessName = "publicBusinessName"
        case registrationNumber = "vat"
        case businessTypes = "venues"
        case businessHours = "openingHours"
        case businessEntertainments = "entertainments"

        case photos = "profileCoverPhotos"

        case isAccessToRewindFeatureEnable = "enableRewindFeature"
        case isPushNotificationEnable = "enablePushNotification"
        case isEmailNotificationEnable = "enableEmailNotification"
        case isTextNotificationEnable = "enableTextNotification"

        case isUserAccountExist = "isUserExist"
        case isBusinessAccountExist = "isBusinessExist"

    }

    func isUserProfileCompleted() -> Bool {
       // return false

        guard let firstName = self.firstName, let dob = self.dob else {
            return false
        }

        if !firstName.isEmpty && dob > 0 {
            return true
        }

        return false
    }

    func isBusinessProfileCompleted() -> Bool {
        // return false

        guard let firstName = self.firstName,
              let businessName = self.businessName,
              let publicBusinessName = self.publicBusinessName,
              let registrationNumber = self.registrationNumber,
              let businessTypes = self.businessTypes,
              let businessHours = self.businessHours,
              let businessEntertainments = self.businessEntertainments,
              let photos = self.photos else {
            return false
        }

        if firstName.isEmpty || businessName.isEmpty || publicBusinessName.isEmpty || registrationNumber.isEmpty || businessTypes.isEmpty || businessHours.isEmpty || businessEntertainments.isEmpty || photos.isEmpty {
            return false
        }

        return true
    }
}

