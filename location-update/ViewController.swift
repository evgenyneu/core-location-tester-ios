//
//  ViewController.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

  @IBOutlet weak var mapView: MKMapView!

  @IBOutlet weak var textView: UITextView!
  var locationManager: CLLocationManager!
  var log: Log!
  var overlay: Annotation?

  var zoomedToLocation = false

  override func viewDidLoad() {
    super.viewDidLoad()

    log = Log(textView: textView)

    startLocationManager()
    mapView.delegate = self
  }

  private func startLocationManager() {
    locationManager = CLLocationManager()
    locationManager.delegate = self

    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    log.add("kCLLocationAccuracyBest \(kCLLocationAccuracyBest)")
    log.add("desiredAccuracy \(locationManager.desiredAccuracy)")

    println("kCLLocationAccuracyHundredMeters \(kCLLocationAccuracyHundredMeters)")

    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

    log.add("kCLDistanceFilterNone \(kCLDistanceFilterNone)")
    log.add("distanceFilter \(locationManager.distanceFilter)")

    locationManager.distanceFilter = 10

    log.add("CLActivityTypeOther \(CLActivityType.Other.rawValue)")
    log.add("activityType \(locationManager.activityType.rawValue)")

    locationManager.activityType = CLActivityType.Fitness

    locationManager.startUpdatingLocation()
  }

  private func updateOverlay(coordinate: CLLocationCoordinate2D) {
    if let currentOverlay = overlay {
      mapView.removeOverlay(overlay)
      overlay = nil
    }

    overlay = Annotation(centerCoordinate: coordinate, radius: 130)
    mapView.addOverlay(overlay)

    zoomToLocation(coordinate)
  }

  private func zoomToLocation(coordinate: CLLocationCoordinate2D) {
    if zoomedToLocation { return }
    zoomedToLocation = true

    InitialMapZoom.zoomToLocation(mapView, coordinate: coordinate, animated: true)
  }
}

typealias CLLocationManagerDelegate_implementation = ViewController

extension CLLocationManagerDelegate_implementation {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    for location in locations {
      if let currentLocation = location as? CLLocation {
        let elapsed = NSDate().timeIntervalSinceDate(currentLocation.timestamp)
        if elapsed > 1 {
          log.add("LARGE elapsed \(elapsed)")
          return
        } // process only recent timestamps

        updateOverlay(currentLocation.coordinate)

        log.add("\(Log.coordToString(currentLocation)) accuracy: \(currentLocation.horizontalAccuracy)")
      }
    }
  }
}

