//
//  AppDelegate.swift
//  breakingbadapi
//
//  Created by David Martin on 3/12/20.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Components.initInjections()
        return true
    }
}

