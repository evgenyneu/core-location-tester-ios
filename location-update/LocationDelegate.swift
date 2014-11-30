//
//  LocationDelegate.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDelegate: class {
  func locationUpdated(coordinate: CLLocationCoordinate2D)
}