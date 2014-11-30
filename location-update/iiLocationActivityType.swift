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
      return "Automotive navigation"
    case .OtherNavigation:
      return "Other navigation"
    case .Other:
      return "Other"
    }
  }
}