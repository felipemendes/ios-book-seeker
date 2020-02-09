//
//  AppDelegate.swift
//  BookSeeker
//
//  Created by Teobaldo Mauro de Moura on 26/09/19.
//  Copyright © 2019 CIT. All rights reserved.
//

import UIKit
import CoreData
import Swinject

// swiftlint:disable force_cast
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowController: FlowController?
    let assembler = Assembler(DepedencyInjection.build())

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        handleFirstPresentation()
        return true
    }

    // MARK: - SETUP

    private func handleFirstPresentation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()

        presentMain(from: window?.rootViewController as! UINavigationController)

        window?.makeKeyAndVisible()
    }

    // MARK: - Core Data

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK: - FlowControllers

extension AppDelegate {

    // MARK: Main

    func presentMain(from navigationController: UINavigationController) {
        flowController = assembler.resolver.resolve(FlowController.self, argument: navigationController)
        flowController?.start()
    }
}
