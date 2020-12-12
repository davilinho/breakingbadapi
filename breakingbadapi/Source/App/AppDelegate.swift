//
//  AppDelegate.swift
//  breakingbadapi
//
//  Created by David Martin on 3/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Components.initInjections()
        return true
    }
}

