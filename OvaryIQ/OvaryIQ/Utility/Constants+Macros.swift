//
//  Constants+Macros.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
import UIKit

// Macros
let kISIPAD            = UIDevice.current.userInterfaceIdiom == .pad
let kISIPHONE          = UIDevice.current.userInterfaceIdiom == .phone
let kISUNSP            = UIDevice.current.userInterfaceIdiom == .unspecified

// (320 x 480 & 640 x 960)
let kISIPHONE4 = UIScreen.main.bounds.size.height == 480.0 ? true : false

// (320 x 568 & 640 x 1136)
let kISIPHONE5 = UIScreen.main.bounds.size.height == 568.0 ? true : false

// (375 x 667 & 750 x 1334)
let kISIPHONE8 = UIScreen.main.bounds.size.height == 667.0 ? true : false

// (414 x 736 & 1242 x 2208)
let kISIPHONE8Plus = UIScreen.main.bounds.size.height == 736.0 ? true : false

// (414 x 896 & 828 x 1792)
let kISIPHONEXr = UIScreen.main.bounds.size.height == 896.0 ? true : false

// (375 x 812 & 1125 x 2436)
let kISIPHONEXs = UIScreen.main.bounds.size.height == 812.0 ? true : false

// (414 x 896 & 1242 x 2688)
let kISIPHONEXsMax = UIScreen.main.bounds.size.height == 896.0 ? true : false

let kAppDelegate            = UIApplication.shared.delegate as? AppDelegate
let kSceneDelegate          = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
// let kAppName                = AppConfig.getAppName()
let kAppName                = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "Alert"
let kAppVersion             = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let kAppVersionM            = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
let kDeviceSize             = UIScreen.main.bounds.size
let kDeviceWidth            = kDeviceSize.width
let kDeviceHeight           = kDeviceSize.height
let kUserDefaults           = UserDefaults.self
let kApplication            = UIApplication.shared
let kNotificationCenter     = NotificationCenter.default
let kFileManager            = FileManager.default
let kMainBundle             = Bundle.main
let kMainThread             = Thread.main
let kMainScreen             = UIScreen.main
let kCurrentCalendar        = Calendar.current
let kCurrentDevice          = UIDevice.current
let kOSVersion              = UIDevice.current.systemVersion
let kIsSimulator            = (TARGET_IPHONE_SIMULATOR != 0)
let kLatLongRoundPlace      = 8
let kMinAge                 = 18
let kMaxAge                 = 100
let kMinHeight              = "3.0"
let kMinBusinessHoursTime   = 0600
let kMaxBusinessHoursTime   = 1800
let kDefaultPageSize        = 10
let kRewindSubscriptionMonthlyPrice          = 2.99
let kRewindSubscriptionYearlyPrice           = 19.99
let kConnectWithUserSubscriptionMonthlyPrice = 9.99
let kConnectWithUserSubscriptionYearlyPrice  = 29.99
