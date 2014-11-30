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

class ViewController: UIViewController, MKMapViewDelegate, LocationDelegate {

  @IBOutlet weak var mapView: MKMapView!

  @IBOutlet weak var textView: UITextView!
  var overlay: Annotation?

  var zoomedToLocation = false

  override func viewDidLoad() {
    super.viewDidLoad()

    AppDelegate.current.log.setTextView(textView)

    AppDelegate.current.location.delegate = self
    AppDelegate.current.location.start()
    mapView.delegate = self
  }

  private func updateOverlay(coordinate: CLLocationCoordinate2D) {
    if let currentOverlay = overlay {
      mapView.removeOverlay(overlay)
      mapView.removeAnnotation(overlay)
      overlay = nil
    }

    overlay = Annotation(centerCoordinate: coordinate, radius: 130)
    mapView.addOverlay(overlay)
    mapView.addAnnotation(overlay)

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
    updateOverlay(coordinate)
  }
}




