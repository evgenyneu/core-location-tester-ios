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

    log.add("kCLLocationAccuracyBest \(kCLLocationAccuracyBest)")
    log.add("desiredAccuracy \(locationManager.desiredAccuracy)")

    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

    log.add("kCLDistanceFilterNone \(kCLDistanceFilterNone)")
    log.add("distanceFilter \(locationManager.distanceFilter)")

    locationManager.distanceFilter = 10

    log.add("CLActivityTypeOther \(CLActivityType.Other.rawValue)")
    log.add("activityType \(locationManager.activityType.rawValue)")

    locationManager.activityType = CLActivityType.Fitness

    locationManager.startUpdatingLocation()
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
