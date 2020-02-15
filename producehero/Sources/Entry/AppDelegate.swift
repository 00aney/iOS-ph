//
//  AppDelegate.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-14.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = rootViewController()
    window!.makeKeyAndVisible()
    
    return true
  }
  
  private func rootViewController() -> UINavigationController? {
    let navigationController = UINavigationController()
    let storyboard = UIStoryboard(name: "RoutesViewController", bundle: nil)
    let routesViewController = storyboard.instantiateInitialViewController() as! RoutesViewController
    navigationController.viewControllers = [routesViewController]
    return navigationController
  }
  
}

