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

/*
// MARK: - XCGLogger

///https://github.com/DaveWoodCom/XCGLogger

class Logger {

    // Create log methods
    static let log: XCGLogger = {

        // Create a logger object with no destinations
        let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)

        // Create a destination for the system console log (via NSLog)
        let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.appleSystemLogDestination")

        // Optionally set some configuration options
        systemDestination.outputLevel = .debug
        systemDestination.showLogIdentifier = false
        systemDestination.showFunctionName = true
        systemDestination.showThreadName = false
        systemDestination.showLevel = true
        systemDestination.showFileName = true
        systemDestination.showLineNumber = true

        // Add the destination to the logger
        log.add(destination: systemDestination)

        // Create a file log destination
        let logPath: URL = Logger.documentsDirectory.appendingPathComponent("XCGLogger_Log.txt")
        let autoRotatingFileDestination = AutoRotatingFileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination", shouldAppend: true, attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication], // Set file attributes on the log file
            maxFileSize: 1024 * 1024, // 5k, not a good size for production (default is 1 megabyte)
            maxTimeInterval: 60 * 60 * 24, // 1 minute, also not good for production (default is 10 minutes)
            targetMaxLogFiles: 10) // Default is 10, max is 255

        // Optionally set some configuration options
        autoRotatingFileDestination.outputLevel = .debug
        autoRotatingFileDestination.showLogIdentifier = false
        autoRotatingFileDestination.showFunctionName = false
        autoRotatingFileDestination.showThreadName = false
        autoRotatingFileDestination.showLevel = true
        autoRotatingFileDestination.showFileName = false
        autoRotatingFileDestination.showLineNumber = false
        autoRotatingFileDestination.showDate = true

        // Process this destination in the background
        autoRotatingFileDestination.logQueue = XCGLogger.logQueue

        // Add the destination to the logger
        log.add(destination: autoRotatingFileDestination)

        let formatter = DateFormatter()
        formatter.dateFormat = "DD/MM/YYYY HH:mm:ss.SSS ZZZ"
        log.dateFormatter = formatter

        // default output level
        log.outputLevel = .debug

        // Add basic app info, version info etc, to the start of the logs
        log.logAppDetails()

        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
        emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
        log.formatters = [emojiLogFormatter]

        return log
    }()

    // Document directory
    static let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    static func verbose(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.verbose(msg)
    }

    static func debug(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.debug(msg)
    }

    static func info(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.info(msg)
    }

    static func warning(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.warning(msg)
    }

    static func error(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.error(msg)
    }

    static func severe(_ sender: AnyObject, filename: String = #file, function: String = #function, line: Int = #line) {
        let msg = "[\((filename as NSString).lastPathComponent):\(line)] \(function) \(sender)"
        log.severe(msg)
    }

    static func updateLogLevel(level: XCGLogger.Level) {
        log.outputLevel = level
    }

    // Get log files
    static func getLogFiles() -> [AnyObject] {
        var files = [AnyObject]()
        let documentsURL = Logger.documentsDirectory
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            // process files
            for url in fileURLs {
                let name = url.lastPathComponent
                if name.contains("XCGLogger") {
                    files.append(url as AnyObject)
                }
            }
        } catch {
            print("Logger :: Error while enumerating files :: \(documentsURL.path): \(error.localizedDescription)")
        }
        return files
    }
}
*/

// MARK: - BugLife Configuration

///https://github.com/Buglife/Buglife-iOS

//extension Logger {
//    static func configureBuglife() {
//        Buglife.shared().start(withEmail: email)
//        Buglife.shared().invocationOptions = buglifeInvocationOptions
//    }
//
//    static let buglifeInvocationOptions: LIFEInvocationOptions = {
//        return [.screenshot]
//    }()
//
//    // Email whom you want to get the bugs.
//    static let email: String = {
//        return "youremailaddress"
//    }()
//}
