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
  private(set) var allArray = [ControlData]()
  private(set) var all = [ControlType:ControlData]()

  func setup() {
    allArray.append(ControlData(
      type: ControlType.accuracy,
      defaults: SliderDefaults(value: -1, minimumValue: -1, maximumValue: 1000)
      ))

    allArray.append(ControlData(
      type: ControlType.distanceFilter,
      defaults: SliderDefaults(value: -1, minimumValue: -1, maximumValue: 100)
      ))

    var activityDefaults = SliderDefaults(value: 1, minimumValue: 1, maximumValue: 4)
    activityDefaults.step = 1

    for i in (Int(activityDefaults.minimumValue)...Int(activityDefaults.maximumValue)) {
      if let currentActivityType = CLActivityType(rawValue: i) {
        activityDefaults.valueNames[Float(i)] = iiLocationActivityType.toString(currentActivityType)
      }
    }

    allArray.append(ControlData(
      type: ControlType.activityType,
      defaults: activityDefaults
      ))


    for data in allArray {
      all[data.type] = data
    }
  }

  func value(type: ControlType) -> Float {
    if let type = all[type] {
      if let sliderView = type.view {
        return sliderView.value
      } else {
        return type.defaults.value
      }
    }
    
    return 0
  }
}
