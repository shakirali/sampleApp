//
//  AppDelegate.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    configureInitialViewController()
    return true
  }

}

extension AppDelegate {
  
  private func configureInitialViewController() {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let votingViewController = InitialViewControllerFactory(storyboard: storyboard).viewController(
      withDataProvider:  DogDataProvider(),
      localizedDataProvider: LocalizedDataProvider())
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = votingViewController
    window?.makeKeyAndVisible()
  }
}

