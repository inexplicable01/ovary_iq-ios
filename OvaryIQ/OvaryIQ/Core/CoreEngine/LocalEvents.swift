//
//  LocalEvents.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation

let minLocalEvent  =   2000
let maxLocalEvent  =   2999

enum LocalEvents: Int {
    case fetchUser = 2000
    case deleteUserPhoto
}

class LocalEngineEvents: EngineEvents {
    required init(id: LocalEvents, obj: Any?) {
        super.init()
        self.eventID = id.rawValue
        self.object = obj
    }
}
