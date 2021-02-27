//
//  AppDelegate.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Variable
    var window: UIWindow?
    
    // MARK: - Application Life cycle -
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        plog(paths[0])
        
        #endif
        return true
    }
}
