//
//  SharedPref.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import UIKit

// https://www.avanderlee.com/swift/property-wrappers/
// https://www.swiftbysundell.com/articles/property-wrappers-in-swift/
// https://swiftsenpai.com/swift/create-the-perfect-userdefaults-wrapper-using-property-wrapper/

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct SharedPref<Value> {
    let key: String
    let defaultValue: Value

    var wrappedValue: Value {
        get {
            let value = UserDefaults.standard.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            // UserDefaults.standard.setValue(newValue, forKey: key)
            if let optional = newValue as? AnyOptional, optional.isNil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.setValue(newValue, forKey: key)
            }
        }
    }
}

extension SharedPref where Value: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}
