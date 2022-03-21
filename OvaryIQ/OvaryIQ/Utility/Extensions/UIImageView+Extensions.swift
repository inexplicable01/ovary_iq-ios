//
//  UIImageView+Extensions.swift
//  OvaryIQ
//
//  Created by Mobcoder on 17/02/22.
//

import Foundation
import UIKit
extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
