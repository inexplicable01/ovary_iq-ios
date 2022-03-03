//
//  Enums.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
enum LoginType: String {
    case google = "google"
    case facebook = "facebook"
    case apple = "apple"

}

enum PeriodCycleType: String {
   case regular = "regular"
   case irregular = "irregular"
   case notKnow = "not_know"
}

// MARK: - dateformat
enum DateFormat: String {
    case dayMonthYear = "dd/MM/yyyy"
    case day = "dd"
}
enum GoalType: String {
   case getPregnant = "Get Pregnant"
   case periodTracking = "Period Tracking"
}
// MARK: - Log Period SubTypesImages
enum LogPeriodSubTypeImages: String {
    // LOGPERIOD
    case regularFlow = "South_America-Argentina"
    case heavyBledding = "South_America-Brazil"

    var image: String? {
        return  self.rawValue
    }
}
//func geticon(img: String)-> UIImage{
//    LogPeriodSubTypeImages.img.rawvalue
//
//}
