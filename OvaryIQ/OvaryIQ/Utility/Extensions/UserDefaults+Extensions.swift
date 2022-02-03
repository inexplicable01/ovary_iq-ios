//
//  UserDefaults+Extension.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {

    struct UDKey {
        static let IsFirstLaunch             = "UD_Key_Is_First_Launch"
        static let DeviceToken               = "UD_Key_Device_Token"
        static let AccessToken               = "UD_Key_Access_Token"
        static let TokenType                 = "UD_Key_TokenType"
        static let RefreshToken              = "UD_Key_Refresh_Token"

        static let IsUserLogin               = "UD_Key_Is_User_Login"
        static let IsProfileCompleted        = "UD_Key_Is_Profile_Completed"
        static let UserType                  = "UD_Key_User_Type"
        static let UserId                    = "UD_Key_User_Id"
        static let UserFirstName             = "UD_Key_User_First_Name"
        static let UserLastName              = "UD_Key_User_Last_Name"
        static let UserLatitude              = "UD_Key_User_Latitude"
        static let UserLongitude             = "UD_Key_User_Longitude"
        static let UserLocation              = "UD_Key_User_Location"

    }

    @SharedPref(key: UDKey.IsFirstLaunch, defaultValue: false)
    static var isFirstLaunch: Bool

    @SharedPref(key: UDKey.DeviceToken, defaultValue: "")
    static var deviceToken: String

    @SharedPref(key: UDKey.AccessToken, defaultValue: "")
    static var accessToken: String

    @SharedPref(key: UDKey.TokenType, defaultValue: "")
    static var tokenType: String

    @SharedPref(key: UDKey.RefreshToken, defaultValue: "")
    static var refreshToken: String

    @SharedPref(key: UDKey.IsUserLogin, defaultValue: false)
    static var isUserLogin: Bool

    @SharedPref(key: UDKey.IsProfileCompleted, defaultValue: false)
    static var isProfileCompleted: Bool

//    @SharedPref(key: UDKey.UserType, defaultValue: UserType.user.rawValue)
//    static var userType: Int

    @SharedPref(key: UDKey.UserId, defaultValue: "")
    static var userId: String

    @SharedPref(key: UDKey.UserFirstName, defaultValue: "")
    static var userFirstName: String

    @SharedPref(key: UDKey.UserLastName, defaultValue: "")
    static var userLastName: String

    @SharedPref(key: UDKey.UserLatitude, defaultValue: 0.0)
    static var userLatitude: Double

    @SharedPref(key: UDKey.UserLongitude, defaultValue: 0.0)
    static var userLongitude: Double

    @SharedPref(key: UDKey.UserLocation, defaultValue: "")
    static var userLocation: String

    func clear() {
        self.set("", forKey: UDKey.AccessToken)
        self.set("", forKey: UDKey.TokenType)
        self.set("", forKey: UDKey.RefreshToken)

        self.set(nil, forKey: UDKey.UserId)
        self.set(false, forKey: UDKey.IsUserLogin)
        self.set(false, forKey: UDKey.IsProfileCompleted)
        self.set(nil, forKey: UDKey.UserType)
    }
}
