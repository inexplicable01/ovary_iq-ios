//
//  Toast.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import Foundation
import SwiftEntryKit

class Toast {

    static let shared = Toast()

    func showAlert(type: AlertToastType, message: String) {
        var attributes = EKAttributes()
        attributes.windowLevel = .statusBar
        attributes.position = .top
        attributes.displayDuration = 2.0
//        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.init(red: 237/255, green: 34/255, blue: 129/255, alpha: 1)), EKColor(.init(red: 72/255, green: 166/255, blue: 68/255, alpha: 1))], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        switch type {
        case AlertToastType.successAlert:
            attributes.entryBackground = .color(color: EKColor(UIColor.init(named: "ThemeColor")!))
        case AlertToastType.apiFailureAlert:
            attributes.entryBackground = .color(color: EKColor(UIColor.init(named: "RedColor")!))
        case AlertToastType.validationFailureAlert:
            attributes.entryBackground = .color(color: EKColor(UIColor.init(named: "RedColor")!))
        }
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        let title = EKProperty.LabelContent.init(text: message, style: .init(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: .white))
        let description = EKProperty.LabelContent.init(text: "", style: .init(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: .white))
        let simpleMessage = EKSimpleMessage.init(title: title, description: description)
        let notificationMessage = EKNotificationMessage.init(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)

    }
}
