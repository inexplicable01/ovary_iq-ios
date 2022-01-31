//
//  Encodable+Extension.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit

extension Encodable {
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [String: Any]() }

        if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return dictionary
        } else {
            return [String: Any]()
        }
    }

    var array: [[String: Any]] {
        guard let data = try? JSONEncoder().encode(self) else { return [[String: Any]]() }

        if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] {
            return dictionary
        } else {
            return [[String: Any]]()
        }
    }
}
