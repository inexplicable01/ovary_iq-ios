//
//  Logger.swift
//  OvaryIQ
//
//  Created by Mobcoder on 13/01/22.
//

//
//  Logger.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit
// import XCGLogger

#if DEBUG
    func dLog(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
        print("[\((filename as NSString).lastPathComponent):\(line)] \(function) - \(String(describing: message))")
    }

    func classStart(filename: String = #file, function: String = #function, line: Int = #line) {
        print("ClassStart", "[\((filename as NSString).lastPathComponent):\(line)] \(function)")
    }

    func classEnd(filename: String = #file, function: String = #function, line: Int = #line) {
        print("ClassEnd", "[\((filename as NSString).lastPathComponent):\(line)] \(function)")
    }

    func classReleased(filename: String = #file, function: String = #function, line: Int = #line) {
        print("ClassReleased", "[\((filename as NSString).lastPathComponent):\(line)] \(function)")
    }

    func fLog(filename: String = #file, function: String = #function, line: Int = #line) {
        print("FlowAction", "[\((filename as NSString).lastPathComponent):\(line)] \(function)")
    }

#else
    func dLog(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    }

    func classStart(filename: String = #file, function: String = #function, line: Int = #line) {
    }

    func classEnd(filename: String = #file, function: String = #function, line: Int = #line) {
    }

    func classReleased(filename: String = #file, function: String = #function, line: Int = #line) {
    }

    func fLog(filename: String = #file, function: String = #function, line: Int = #line) {
    }

#endif

class Logger {
}
