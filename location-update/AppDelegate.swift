//
//  AppDelegate.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let allControls = [ControlType:ControlData]()

  let allControlsDataArray = [
    ControlData(
      type: ControlType.accuracy,
      defaults: SliderDefaults(value: 100, minimumValue: 0, maximumValue: 1000)
    ),

    ControlData(
      type: ControlType.distanceFilter,
      defaults: SliderDefaults(value: 10, minimumValue: 0, maximumValue: 1000)
    ),

    ControlData(
      type: ControlType.activityType,
      defaults: SliderDefaults(value: 3, minimumValue: 0, maximumValue: 4),
      step: 1
    )
  ]

  let log = Log()
  let location = Location()

  override init() {
    super.init()

    for data in allControlsDataArray {
      allControls[data.type] = data
    }
  }

  func controlValue(type: ControlType) -> Float {
    if let sliderView = allControls[type]?.view {
      return sliderView.value
    }

    return 0
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  class var current: AppDelegate {
    return UIApplication.sharedApplication().delegate as AppDelegate
  }

}

