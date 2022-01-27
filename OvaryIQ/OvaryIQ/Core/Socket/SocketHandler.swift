//
//  SocketHandler.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//
//  SocketHandler.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
//import SocketIO
//
// Events which are used to get and send data over socket.io
//enum SocketEventString: String {
//    case recieveMessage = "receiveMessage"
//    case sendMessage = "sendMessage"
//    case userListData = "userListData"
//    case joinRoom  = "joinRoom"
//    case setAnotherProfile = "setAnotherProfile"
//    case switchProfile = "switchProfile"
//    case disconnect = "disconnect"
//}
//
//class SocketHandler: NSObject {
//    var manager = SocketManager.init(socketURL: URL(string: AppConfig.getSocketBaseURL())!)
//    var socket: SocketIOClient!
//
//    // Shared instance of class
//    class var sharedInstance: SocketHandler {
//        struct Singleton {
//            static let instance: SocketHandler? = SocketHandler()
//        }
//
//        return Singleton.instance!
//    }
//
//    /*
//     Default methods of socket
//    fileprivate func addSocketEventListners() {
//        socket.on(clientEvent: .connect) {data, ack in
//            self.handleRecvMessage(data: data, event: .CONNECT_CALLBACK)
//        }
//
//        socket.on(clientEvent: .pong) {data, ack in
//        }
//
//        socket.on(clientEvent: .ping) {data, ack in
//        }
//
//        socket.on(clientEvent: .error) {data, ack in
//            Logger.debug("Socket Error: \(data)" as AnyObject)
//        }
//
//        socket.on(clientEvent: .reconnect) {data, ack in
//        }
//
//        socket.on(clientEvent: .reconnectAttempt) {data, ack in
//        }
//
//        socket.on(clientEvent: .statusChange) {data, ack in
//        }
//
//        socket.onAny { (event) in
//            print(event.event)
//            print(event.description)
//        }
//    }
//
//     Socket methods to get the call back
//    internal func addConnectedListeners() {
//        socket.on(SocketEventString.Recieve_Message.rawValue) { (data, ack) in
//            self.handleRecvMessage(data: data, event: .RECEIVE_MESSAGE)
//        }
//
//        socket.on(SocketEventString.UserList_Data.rawValue) { (data, ack) in
//            self.handleRecvMessage(data: data, event: .USERLIST_DATA)
//        }
//
//        socket.on(SocketEventString.Join_Room.rawValue) { (data, ack) in
//            self.handleRecvMessage(data: data, event: .JOIN_ROOM)
//        }
//
//        socket.on(SocketEventString.Set_Another_Profile.rawValue) { (data, ack) in
//            self.handleRecvMessage(data: data, event: .SET_ANOTHER_PROFILE)
//        }
//
//        socket.on(SocketEventString.Switch_Profile.rawValue) { (data, ack) in
//            self.handleRecvMessage(data: data, event: .SWITCH_PROFILE)
//        }
//
//    }
//
//     MARK: - Send message
//    public func sendMessageWithSocketID(_ params: [String: Any]) {
//        socket.emit(SocketEventString.Send_Message.rawValue, params.toJSONString()!)
//    }
//
//     MARK: - Join Room
//    public func joinRoomWithSocketID(_ params: [String: Any]) {
//        socket.emit(SocketEventString.Join_Room.rawValue, params.toJSONString()!)
//    }
//
//     MARK: - Set Another Profile
//    public func setAnotherProfileWithSocketID(_ params: [String: Any]) {
//        socket.emit(SocketEventString.Set_Another_Profile.rawValue, params.toJSONString()!)
//    }
//
//    fileprivate func handleRecvMessage(data: Any, event: SocketEvents){
//        let socketEvent = SocketEngineEvents.init(id:event, obj: data as AnyObject)
//        CoreEngine.shared.addEvent(evObj: socketEvent)
//    }
//
//     MARK: - Connect socket
//    internal func connectSocket() {
//        if let socket = socket,
//            socket.status == .connected {
//            Logger.debug("Already connected no need to connect again" as AnyObject)
//        } else {
//            if let accessToken = USER_DEFAULTS.value(forKey: kaccessToken) as? String {
//                manager.config = [ .compress, .connectParams([kaccessToken : accessToken]), .forceWebsockets(true), .forceNew(true), .forcePolling(false), .reconnects(true), .reconnectWait(60), .reconnectWaitMax(120), .reconnectAttempts(1)]
//
//                socket = manager.defaultSocket
//                socket.removeAllHandlers()
//                socket.connect()
//                addSocketEventListners()
//                addConnectedListeners()
//            }else{
//                Logger.debug("Unable to connect socket due to access token not found." as AnyObject)
//            }
//        }
//    }
//
//    internal func disConnectSocket() {
//        if let socket = socket,
//           socket.status == .connected {
//            socket.disconnect()
//            manager = SocketManager.init(socketURL: URL(string: AppConfig.getSocketURL())!)
//        }
//    }
//     */
//}
//
