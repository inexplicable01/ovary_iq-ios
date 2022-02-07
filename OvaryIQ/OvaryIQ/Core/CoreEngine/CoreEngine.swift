//
//  CoreEngine.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import Alamofire

let kBaseRegisterId =   100

class EngineEvents {
    var eventID: Int =   0
    var object: Any?
}

enum EventCallBack: String {
    case restCallBack = "restEventListenerCallBack"
    case socketCallBack = "socketEventListenerCallBack"
    case localCallBack = "localEventListenerCallBack"
}

class CoreEngine: EventLoop {

    static let shared = CoreEngine()

    private var restHelper = RestHelper.shared
  //  private var socketHandler = SocketHandler.sharedInstance
  //  private var databaseHandler = DatabaseHandler.shared
    private var cbHndler = [String: Any]()
    private var currentRegIdx = 0
    private var mutex = NSLock()

    // feature toggle variables
    internal var autoDownloadImages  = true
    internal var autoDownloadAudio   = true
    internal var autoDownloadVideo   = true
    internal var isNetworkReachable  = false
    internal var userInfo: UserInfo? = nil

    private var progressHudCount = 0

    // MARK: - InIt Method

    private override init() {
        super.init()

        //Start Thread here
        self.start()
        self.name = "CoreEngine"

        let networkManager = NetworkManager()
        self.isNetworkReachable = !(networkManager.reachabilityManager?.status == .notReachable)
    }

    // MARK: - Public Methods

    public override func addEvent(evObj: EngineEvents) {
        return super.addEvent(evObj: evObj)
    }

    public func addEngineEventsWithOutWait(evObj: EngineEvents) {
        self.processQueuedEvent(evobj:evObj)
    }

    public func registerEventCallBack(cbType: EventCallBack, cbBlock: @escaping(_ eventID: Int, _ result: Int, _ response: Any?, _ message: String?, _ isSuccess: Bool) -> Void) -> String {

        self.mutex.lock()

        var cbhndl: [String: Any]?

        if self.cbHndler[cbType.rawValue] != nil {
            cbhndl = (self.cbHndler[cbType.rawValue] as! [String: Any])
        } else {
            cbhndl = [String: Any]()
        }

        self.currentRegIdx += 1

        let regID = String(format: "%d", self.currentRegIdx)
        cbhndl?[regID] = cbBlock

        self.cbHndler[cbType.rawValue] = cbhndl

        self.mutex.unlock()

        return regID
    }

    public func unregisterEventForID(cbType: EventCallBack, regId: String) {
        self.mutex.lock()

        if var cbhndl = self.cbHndler[cbType.rawValue] as? [String: Any]{
            cbhndl.removeValue(forKey: regId)
            self.cbHndler[cbType.rawValue] = cbhndl
        }

        self.mutex.unlock()
    }

    internal override func processQueuedEvent(evobj: Any) {
        if let events = evobj as? EngineEvents{
            switch events.eventID {
            case minRestEvent ... maxRestEvent:
                self.processRestEvents(evobj: events as! RestEngineEvents)
            case minLocalEvent ... maxLocalEvent:
                self.processLocalEvents(evobj: events)
            case minSocketEvent ... maxSocketEvent:
                self.processSocketEvents(evobj: events)
            default:
                break
            }
        } else {

        }
    }

    // MARK: - Private Methods

    /**
     Reachability of the network
     */
    private func isConnectedToInternet() -> Bool {
        // Check network connection again
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    private func processRestEvents(evobj: RestEngineEvents) {

        fLog()

        if evobj.state == .NONE {

            if self.isNetworkReachable {

                self.progressHudCount = self.progressHudCount + 1
                dLog(message: "Add :: Hud Count :: \(self.progressHudCount)")

                if evobj.showActivityIndicator {
                    DispatchQueue.main.async {
                        Helper.showLoader()
                        
                        //ActivityIndicatorManager.sharedInstance.showActivityIndicator()
                        //Loader.showLoader()
                    }
                }

                self.restHelper.processRestRequest(evObj: evobj)

            } else {
                DispatchQueue.main.async {
                    Helper.hideLoader()
                   AlertControllerManager.showToast(message: ErrorMessages.noInternetConnection.localizedString, type: AlertType.warning)
                }
            }

            let networkManager = NetworkManager()
            self.isNetworkReachable = !(networkManager.reachabilityManager?.status == .notReachable)

        } else if evobj.state == .PROCESSING {

            //update the progess of uploading / downloading the files

        } else if evobj.state == .COMPLETED {

            DispatchQueue.main.async {

                //ActivityIndicatorManager.sharedInstance.hideActivityIndicator()

                if self.progressHudCount > 0 {
                    self.progressHudCount = self.progressHudCount - 1
                    dLog(message: "Remove :: Hud Count :: \(self.progressHudCount)")
                }

                if self.progressHudCount <= 0 {
                    dLog(message: "Reset :: Hud Count :: \(self.progressHudCount)")
                    self.progressHudCount = 0
                    Helper.hideLoader()
                }
            }

            let eventID = RestEvents(rawValue: evobj.eventID)!
            var notifyToGUI = false

            dLog(message: "Response for :: \(evobj.eventID) is :: \(String(describing: evobj.object))")

            switch (eventID) {
            case .SignUp:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .login:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .logout:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
                    DispatchQueue.main.async {
                            self.logoutMethod()
                    }
            }
            case .fetchGoal:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .saveUserFetchGoalDetails:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .forgotPassword:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .verifyCode:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            case .resetPassword:
                if let responseDict = evobj.object as? [String: Any], !self.validateResponseError(response: responseDict) {
                    notifyToGUI = true
            }
            default :
                if let responseDict = evobj.object as? [String: Any],
                    !self.validateResponseError(response: responseDict) {

                } else {
                    notifyToGUI = false
                }
            }

            // notify the response to the GUI
            dLog(message: "notifyui::",filename: "\(notifyToGUI)")
            if notifyToGUI {
                self.notifyToGUI(cbType: EventCallBack.restCallBack, eventID: evobj.eventID, result: success, response: evobj.object)
            }
        }
    }

    private func processLocalEvents(evobj: EngineEvents) {

        let eventID = LocalEvents(rawValue: evobj.eventID)!

        switch (eventID) {
//        case .fetchUser:
////            if let userInfo = self.databaseHandler.fetchUserWith(userId: kUserDefaults.userId, fromMain: true) {
////                evobj.object  = userInfo
////                self.userInfo = userInfo
////            }
//
//            self.notifyToGUI(cbType: EventCallBack.localCallBack, eventID: evobj.eventID, result: success, response: evobj.object)
//
////        case .deleteUserPhoto:
////            if let params = evobj.object as? [String: Any],
////                let photoId = params[APIParam.id] as? String {
////                evobj.object = self.databaseHandler.deleteUserPhoto(photoId: photoId)
////            }

        default:
            self.notifyToGUI(cbType: EventCallBack.localCallBack, eventID: evobj.eventID, result: success, response: evobj.object)
            break
        }
    }

    private func processSocketEvents(evobj: EngineEvents) {

        let eventID = SocketEvents(rawValue: evobj.eventID)!
        switch (eventID) {
        default:
            self.notifyToGUI(cbType: EventCallBack.socketCallBack, eventID: evobj.eventID, result: success, response: evobj.object)
            break
        }
    }

    /*
     Notify the reponses directly to the call back handler attach with the Events associated with eventID
     */

    private func notifyToGUI(cbType: EventCallBack, eventID: Int, result: Int, response: Any?) {

        self.mutex.lock()

        dLog(message: "cbHandlerValue...\(self.cbHndler[cbType.rawValue] as? [String: Any])")

        if let cbhndl = self.cbHndler[cbType.rawValue] as? [String: Any] {

            cbhndl.keys.forEach { (key) in
                let completionBlock = cbhndl[key] as! (_ eventID: Int, _ result: Int, _ response: Any?, _ message: String?, _ isSuccess: Bool) -> Void

                if let responseDict = response as? [String: Any] {
                    if let statusCode = responseDict[APIParam.StatusCode] as? Int {

                        if statusCode == 1 {

                            if let responseData = responseDict[APIParam.Data] as? [String: Any] {
                                

                                DispatchQueue.main.async {
                                    completionBlock(eventID, result, responseData, nil, true)
                                }

                            } else {
                                dLog(message: "Error :: Response Data is nil or in wrong format")
                                completionBlock(eventID, result, nil, ErrorMessages.apiFail.localizedString, false)
                            }


                        } else {

                            dLog(message: "Error :: Status Code is 0")
                            completionBlock(eventID, result, nil, ErrorMessages.apiFail.localizedString, false)
                        }

                    } else {
                        dLog(message: "Error :: Status Code is nil or in wrong format")
                        completionBlock(eventID, result, nil, ErrorMessages.apiFail.localizedString, false)
                    }

                } else if let userInfo = response as? UserInfo {
                    completionBlock(eventID, result, userInfo, nil, true)
                } else {
                    dLog(message: "Error :: Response is nil or in wrong format")
                    completionBlock(eventID, result, nil, ErrorMessages.apiFail.localizedString, false)
                }
            }

        } else {
            dLog(message: "Error :: Error here.")
        }

        self.mutex.unlock()
    }

    // MARK: - Add Local Events

    private func addLocalEvents(event: LocalEvents, params: Any? = nil) {
        let localEvent = LocalEngineEvents(id: event, obj: params)
        self.addEvent(evObj: localEvent)
    }

    // MARK: - Add Rest Events

    private func addRestEvents(event: RestEvents, params: Any? = nil) {
        let restEvent = RestEngineEvents(id: event, obj: params)
        self.addEvent(evObj: restEvent)
    }

    // MARK: - Add Socket Events

    private func addSocketEvents(event: SocketEvents, params: Any? = nil) {
        let socketEvent = SocketEngineEvents(id: event, obj: params)
        self.addEvent(evObj: socketEvent)
    }
}

extension CoreEngine {

    // MARK: - Validate response

    func validateResponseError(response: [String: Any], _ isErrorMsgShow: Bool = true) -> Bool {

        var hasError = false

        if let errorDict = response[APIParam.Error] as? [String: Any] {

            hasError = true

            if let errCode = errorDict[APIParam.ErrorCode] as? Int {

                var errorStr = ""

                if let errorMsg = errorDict[APIParam.ResponseMessage] as? String {
                    errorStr = errorMsg
                } else if let errorMsg = errorDict[APIParam.ResponseMessage] as? String {
                    errorStr = errorMsg
                } else if let errors = errorDict[APIParam.Errors] as? [[String: Any]] {

                    for error in errors {
                        if let errorMsg = error[APIParam.Message] as? String {
                            errorStr = errorStr + errorMsg + "\n"
                        }
                    }
                }


                if errCode == 401  || errCode == 2 {
                    // for session expired
                    DispatchQueue.main.async {
                        AlertControllerManager.showAlert(title: AppConfig.getAppName(), message: errorStr, buttons: [Text.oks.localizedString]) { index in
                            self.logoutMethod()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                     //   AlertControllerManager.showToast(message: errorStr, type: AlertType.error)

                        AlertControllerManager.showToast(message: errorStr, type: AlertType.error)
                    }
                }
            }
        }

        return hasError
    }

    // MARK: - Logout from the app

    internal func logoutMethod() {
        self.resetAllKeys()
    }

    // MARK: - Reset all User defaults and Global Variables

    private func resetAllKeys() {
        DispatchQueue.main.async {
            //1. Remove All Data Stored in UserDefault
            kUserDefaults.standard.clear()
            

            //2. Delete All Data from CoreData DB
           // self.databaseHandler.cleanDB()

            //5. Disconnect Socket

            //6. Reset Root of Window
          //  kAppDelegate?.setRootViewC()
            Helper.showLoginScreen()
        }
    }
}

