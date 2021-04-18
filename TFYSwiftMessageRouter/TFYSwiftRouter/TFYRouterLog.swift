//
//  TFYRouterLog.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

internal var TFYRouterLogOn = false

internal func TFYRouterLog(router: String, message: String) {
    if TFYRouterLogOn {
        let logMsg = "[** SRouter **] route to '\(router)' Error =>: " + message
        print(logMsg, "\n")
    }
}

public extension TFYRouterManager {
    static func openLog() {
        TFYRouterLogOn = true
    }
    static func closeLog() {
        TFYRouterLogOn = false
    }
}
