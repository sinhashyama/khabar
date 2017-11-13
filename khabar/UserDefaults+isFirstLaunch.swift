//
//  UserDefaults+isFirstLaunch.swift
//  khabar
//
//  Created by Singh, Abhay on 3/19/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation


extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        return isFirstLaunch
    }
}

extension Date {
    var dayAfter:Date {
        let oneDay:Double = 60 * 60 * 24
        return self.addingTimeInterval(oneDay)
    }
    var dayBefore:Date {
        let oneDay:Double = 60 * 60 * 24
        return self.addingTimeInterval(-(Double(oneDay)))
    }
}
