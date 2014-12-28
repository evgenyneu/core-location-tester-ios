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

  override init() {
    super.init()
  }

  func start() {
    locationManager.delegate = self

    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    startUpdatingLocation()
  }

  func updateLocationSettings() {
    locationManager.desiredAccuracy = CLLocationAccuracy(AppDelegate.current.controls.value(ControlType.accuracy))
    locationManager.distanceFilter = CLLocationDistance(AppDelegate.current.controls.value(ControlType.distanceFilter))

    if let activityType = CLActivityType(rawValue: Int(AppDelegate.current.controls.value(ControlType.activityType))) {

      locationManager.activityType = activityType
    }

    log.add("accuracy: \(locationManager.desiredAccuracy)")
    log.add("distance filter: \(locationManager.distanceFilter)")
    let activityType = iiLocationActivityType.toString(locationManager.activityType)
    log.add("activity type: \(activityType)")
  }

  private func startUpdatingLocation() {
    updateLocationSettings()
    log.add("Start updating location")
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

    if locations.count > 1 {
      log.add("Number of location in one update \(locations.count)")
    }

    for location in locations {
      if let currentLocation = location as? CLLocation {
        let elapsed = NSDate().timeIntervalSinceDate(currentLocation.timestamp)
        var oldUpdate = ""
        if elapsed > 1 {
          oldUpdate = " Old data (\(elapsed) sec ago)"
        } // process only recent timestamps

        delegate?.locationUpdated(currentLocation.coordinate)
        log.add("\(Log.coordToString(currentLocation)) accuracy: \(currentLocation.horizontalAccuracy) \(oldUpdate)")
      }
    }
  }

  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    let title = "Location Error"
    let message = iiCLErrorToString.toString(error.code) + " " + error.description

    log.add("\(title) \(message)")
  }
}
