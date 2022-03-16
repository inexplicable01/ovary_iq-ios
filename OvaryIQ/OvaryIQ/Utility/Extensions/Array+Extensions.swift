//
//  Array.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/03/22.
//

import Foundation
extension Array {
    func toJSONStringFormatted() -> String? {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
                return String(data: jsonData, encoding: String.Encoding.utf8)!
            } catch {
                return nil
            }
        }
}
extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
