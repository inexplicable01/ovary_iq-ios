//
//  RestEvents.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import Alamofire

let minRestEvent  =   1000
let maxRestEvent  =   1999

enum RestEvents: Int {
    case SignUp = 1000
    case login
    case logout
    case fetchGoal
    case saveUserFetchGoalDetails
    case forgotPassword
    case verifyCode
    case resetPassword
    case networkError
    case getDataForLogPeriod
    case saveLogPeriod
    case getUserLogPeriodData
    case change_password
    case userProfile
    case saveUserMedications
    case saveUserProcedures
    case saveUserActivities
    case saveUserSymptoms
    case saveUserPregnancyTests
    case projectionData
    case getUsersMedicalOptionsData
    case updateProfilePhoto
}

class RestEngineEvents: EngineEvents {

    var showActivityIndicator: Bool = false
    var state: RequestState = .NONE
    var priority: RequestPriority = RequestPriority.DEFAULT
    var fastQueue: Bool = true
    var uploadMultipart = false
    var downloadingFile = true // Check only when fastQueue is false
    var apiRequest: URLRequestConvertible?
    var completionBlock:((_ what: Int, _ result: Int, _ response: Any) -> Void)?
    var progressBlock:((_ what: Int, _ progress: Double, _ url: URL) -> Void)?
    var isCancelSentRequest: Bool = false

    required init(id: RestEvents, obj: Any?) {
        super.init()
        self.eventID = id.rawValue
        self.object = obj
    }
}

