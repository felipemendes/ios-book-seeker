//
//  AppDelegate.swift
//  BookSeeker
//
//  Created by Teobaldo Mauro de Moura on 26/09/19.
//  Copyright © 2019 CIT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        handleFirstPresentation()
        return true
    }

    // MARK: - SETUP

    private func handleFirstPresentation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()

        window?.makeKeyAndVisible()
    }
}
