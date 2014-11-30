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

class ViewController: UIViewController, LocationDelegate {

  @IBOutlet weak var mapView: MKMapView!

  @IBOutlet weak var textView: UITextView!
  var annotation: MKCircle?

  var zoomedToLocation = false

  var lastPinLocation: CLLocationCoordinate2D?

  override func viewDidLoad() {
    super.viewDidLoad()

    AppDelegate.current.log.setTextView(textView)

    AppDelegate.current.location.delegate = self
    AppDelegate.current.location.start()
  }

  private func updatePin(coordinate: CLLocationCoordinate2D) {
    if let currentLastPinLocation = lastPinLocation {
      if currentLastPinLocation.latitude == coordinate.latitude &&
        currentLastPinLocation.longitude == coordinate.longitude
      {
        // Pin did not move - no need to update
        return
      }
    }

    lastPinLocation = coordinate

    if let currentAnnotation = annotation {
      mapView.removeAnnotation(currentAnnotation)
      annotation = nil
    }

    annotation =  MKCircle(centerCoordinate: coordinate, radius: 10)
    mapView.addAnnotation(annotation)

    zoomToLocation(coordinate)
  }

  private func zoomToLocation(coordinate: CLLocationCoordinate2D) {
    if zoomedToLocation { return }
    zoomedToLocation = true

    InitialMapZoom.zoomToLocation(mapView, coordinate: coordinate, animated: true)
  }
}

// LocationDelegate
// -------------------------

typealias LocationDelegate_implementation = ViewController

extension LocationDelegate_implementation {
  func locationUpdated(coordinate: CLLocationCoordinate2D) {
    updatePin(coordinate)
  }
}




