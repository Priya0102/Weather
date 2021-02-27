//
//  LIApplication.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit

class LIApplication {
    
    static let shared = LIApplication()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() { }
}

// MARK: - Application Bundle -
extension Bundle {
    var appName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    var appShortVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    var appBuildVersion: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    var appVersion: String {
        return "\(appShortVersion) (\(appBuildVersion))"
    }
}
