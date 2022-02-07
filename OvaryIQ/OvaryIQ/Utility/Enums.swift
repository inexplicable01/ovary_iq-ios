//
//  Enums.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
enum LoginType: Int {
    case google = 1
    case facebook = 2
    case apple = 3
   // case phoneNo = 4

    var value: String {
        switch self {
        case .google: return "1"
        case .facebook: return "2"
        case .apple: return "3"
      //  case .phoneNo: return "4"
        }
    }
}

enum PeriodCycleType: String {
   case regular = "regular"
   case irregular = "irregular"
   case notKnow = "not_know"
}
