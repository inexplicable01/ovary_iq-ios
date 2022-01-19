//
//  UIButton+Extensions.swift
//  OvaryIQ
//
//  Created by Mobcoder on 13/01/22.
//

import Foundation
import UIKit

// MARK: - Designable Extension

@IBDesignable
extension UIButton {

    // MARK: - This is used for apply gradient color on button
    func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - for popViewController
    func goBack() {
        fLog()
    }
}
