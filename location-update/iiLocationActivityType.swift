//
//  iiLocationActivityType.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

struct iiLocationActivityType {
  static func toString(type: CLActivityType) -> String {
    switch type {
    case .Fitness:
      return "Fitness"
    case .AutomotiveNavigation:
      return "AutomotiveNavigation"
    case .OtherNavigation:
      return "OtherNavigation"
    case .Other:
      return "Other"
    }
  }
}