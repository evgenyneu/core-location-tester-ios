//
//  ControlsInit.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

class ControlsStorage {
  var allArray = [ControlData]()
  var all = [ControlType:ControlData]()

  func setup() {
    var activityDefaults = SliderDefaults(value: 3, minimumValue: 1, maximumValue: 4)

    for i in (Int(activityDefaults.minimumValue)...Int(activityDefaults.maximumValue)) {
      if let currentActivityType = CLActivityType(rawValue: i) {
        activityDefaults.valueNames[Float(i)] = iiLocationActivityType.toString(currentActivityType)
      }
    }

    allArray = [
      ControlData(
        type: ControlType.accuracy,
        defaults: SliderDefaults(value: 100, minimumValue: 0, maximumValue: 1000)
      ),

      ControlData(
        type: ControlType.distanceFilter,
        defaults: SliderDefaults(value: 10, minimumValue: 0, maximumValue: 100)
      ),

      ControlData(
        type: ControlType.activityType,
        defaults: activityDefaults,
        step: 1
      )
    ]

    for data in allArray {
      all[data.type] = data
    }
  }

  func value(type: ControlType) -> Float {
    if let sliderView = all[type]?.view {
      return sliderView.value
    }
    
    return 0
  }
}
