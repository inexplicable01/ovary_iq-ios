//
//  SocialUserInfo.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/12/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation

struct SocialUserInfo {
    var type: LoginType = .apple
    var socialId: String = ""
    var name: String = ""
    var email: String = ""
    var profilePic: String = ""

    var firstName: String {
        return Name(fullName: self.name).first
    }

    var lastName: String {
        return Name(fullName: self.name).last
    }
}

//enum SocialLoginType: Int {
//    case facebook = 1
//    case google = 2
//    case apple = 3
//}


struct Name {
    let first: String
    let last: String

    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

extension Name {
    init(fullName: String) {
        var names = fullName.components(separatedBy: " ")
        let first = names.removeFirst()
        let last = names.joined(separator: " ")
        self.init(first: first, last: last)
    }
}

extension Name: CustomStringConvertible {
    var description: String { return "\(first) \(last)" }
}

