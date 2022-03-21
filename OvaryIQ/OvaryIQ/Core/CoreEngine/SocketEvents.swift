//
//  SocketEvents.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//
//  SocketEvents.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation

let minSocketEvent  =   3000
let maxSocketEvent  =   3999

class SocketEngineEvents: EngineEvents {
    required init(id: SocketEvents, obj: Any?) {
        super.init()
        self.eventID = id.rawValue
        self.object = obj
    }
}

enum SocketEvents: Int {
    case    CONNECT =   3000
    case    CONNECT_CALLBACK
    case    CONNECTED_CALLBACK
    case    ADD_DYNAMIC_EVENT
    case    ADD_DYNAMIC_EVENT_CALLBACK
    case    RECONNECT
    case    DISCONNECT
    case    DISCONNECT_CALLBACK
    case    RECONNECT_CALLBACK
    case    ERROR_CALLBACK
    case    PING_CALLBACK
    case    PONG_CALLBACK
    case    STATUS_CHANGE_CALLBACK
    case    RECONNECT_ATTEMPT_CALLBACK
    case    RECEIVE_MESSAGE
    case    SEND_MESSAGE
    case    USERLIST_DATA
    case    JOIN_ROOM
    case    SET_ANOTHER_PROFILE
    case    SWITCH_PROFILE
}
