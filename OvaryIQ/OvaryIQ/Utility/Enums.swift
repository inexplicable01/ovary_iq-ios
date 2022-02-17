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

//MARK: - dateformat
enum DateFormat: String {
    case dayMonthYear = "dd/MM/yyyy"
    case day = "dd"
}
