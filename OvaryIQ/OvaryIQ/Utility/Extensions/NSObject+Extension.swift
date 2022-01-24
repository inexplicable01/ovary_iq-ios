//
//  NSObject+Extension.swift
//  OvaryIQ
//
//  Created by Mobcoder on 18/01/22.
//

import Foundation
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
