//
//  Location.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var log: Log { return AppDelegate.current.log }

  weak var delegate: LocationDelegate?

  func start() {
    locationManager.delegate = self

    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    startUpdatingLocation()
  }

  private func startUpdatingLocation() {

    locationManager.desiredAccuracy = CLLocationAccuracy(AppDelegate.current.controls.value(ControlType.accuracy))
    locationManager.distanceFilter = CLLocationDistance(AppDelegate.current.controls.value(ControlType.distanceFilter))

    if let activityType = CLActivityType(rawValue: Int(AppDelegate.current.controls.value(ControlType.activityType))) {

      locationManager.activityType = activityType
    }

    log.add("Start updating location")
    log.add("accuracy: \(locationManager.desiredAccuracy)")
    log.add("distance filter: \(locationManager.distanceFilter)")

    let activityType = iiLocationActivityType.toString(locationManager.activityType)
    log.add("activity type: \(activityType)")

    locationManager.startUpdatingLocation()
  }

  func restartUpdatingLocation() {
    locationManager.stopUpdatingLocation()

    iiQ.runAfterDelay(1) {
      self.startUpdatingLocation()
    }
  }
}

// CLLocationManagerDelegate
// ---------------------------

typealias CLLocationManagerDelegate_implementation = Location

extension CLLocationManagerDelegate_implementation {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    for location in locations {
      if let currentLocation = location as? CLLocation {
        let elapsed = NSDate().timeIntervalSinceDate(currentLocation.timestamp)
        if elapsed > 1 {
          log.add("LARGE elapsed \(elapsed)")
          return
        } // process only recent timestamps

        delegate?.locationUpdated(currentLocation.coordinate)
        log.add("\(Log.coordToString(currentLocation)) accuracy: \(currentLocation.horizontalAccuracy)")
      }
    }
  }
}
