//
//  AlertControllerManager.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

enum AlertType {
    case success
    case error
    case info
    case warning
}

class AlertControllerManager {

    class func showToast(title: String = kAppName, message: String, type: AlertType, seconds: Int = 0) {

        if message.isEmpty { return }

        var alertType: Theme!
        switch type {
        case .success:
            alertType = .success
        case .error:
            alertType = .error
        case .warning:
            alertType = .warning
        default:
            alertType = .info
        }

        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(alertType)
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        var config = SwiftMessages.Config()
        config.presentationStyle = .top

        if seconds > 0 {
            config.duration = .seconds(seconds: TimeInterval(seconds))
        } else {
            config.duration = .automatic
        }

        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.eventListeners.append() { event in
            if case .didHide = event {}
        }

        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: view)
        }
    }


    class func showAlertWithoutAction(title: String?, message: String) {
        fLog()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }

    class func showOkAlert(title: String?, message: String) {
        fLog()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionCancel = UIAlertAction(title: Text.oks.localizedString, style: .default, handler: nil)
        alertController.addAction(actionCancel)
        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }

    class func showAlert(title: String?, message: String?, buttons: Array<String>?, completion: ((_ buttonIndex: Int) -> Void)?) {
        fLog()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        for index in 0 ..< buttons!.count {
            let buttonTitle = buttons![index]

            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction: UIAlertAction) in
                let buttonIndex = buttons!.firstIndex(of: alertAction.title!)
                if completion != nil {
                    completion!(buttonIndex!)
                }
            })

            alertController.addAction(action)
        }

        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }

    class func showAlertWithTextField(placeholder: String?, title: String?, message: String?, buttons: Array<String>?, completion: ((_ buttonIndex: Int, _ textField: UITextField) -> Void)?) {

        fLog()

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in

            textField.placeholder = placeholder

            for index in 0 ..< buttons!.count {
                let buttonTitle = buttons![index]

                let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction: UIAlertAction) in
                    let buttonIndex = buttons!.firstIndex(of: alertAction.title!)
                    if completion != nil {
                        completion!(buttonIndex!, textField)
                    }
                })

                alertController.addAction(action)
            }
        }

        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }

    class func showActionSheet(title: String?, message: String?, buttons: Array<String>?, completion: ((_ buttonIndex: Int) -> Void)?) {

        fLog()

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)

        for index in 0 ..< buttons!.count {

            let buttonTitle = buttons![index]

            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction: UIAlertAction) in
                let buttonIndex = buttons!.firstIndex(of: alertAction.title!)
                if completion != nil {
                    completion!(buttonIndex!)
                }
            })

            alertController.addAction(action)
        }

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction) in
            if completion != nil {
                completion!(buttons!.count)
            }
        })

        alertController.addAction(actionCancel)

        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }

    class func showActionSheetOnIPad(fromView view: UIView, title: String?, message: String?, buttons: Array<String>?, completion: ((_ buttonIndex: Int) -> Void)?) {

        fLog()

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)

        for index in 0 ..< buttons!.count {

            let buttonTitle = buttons![index]

            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction: UIAlertAction) in
                let buttonIndex = buttons!.firstIndex(of: alertAction.title!)
                if completion != nil {
                    completion!(buttonIndex!)
                }
            })

            alertController.addAction(action)
        }

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction) in
            if completion != nil {
                completion!(buttons!.count)
            }
        })

        alertController.addAction(actionCancel)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
        }

        Utility.topMostViewController(rootViewController: Utility.rootViewController())?.present(alertController, animated: true, completion: nil)
    }
}


