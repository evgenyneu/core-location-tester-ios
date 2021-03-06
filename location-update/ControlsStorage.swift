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
      defaults: SliderDefaults(value: -1, minimumValue: -1, maximumValue: 300)
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
    if let data = all[type] {
      if let sliderView = data.view {
        return sliderView.value
      } else {
        if let currentSavedValue = SliderControlUserDefaults.value(type) {
          return currentSavedValue
        }
        return data.defaults.value
      }
    }
    
    return 0
  }

  func setValue(type: ControlType, value: Float) {
    if let data = all[type] {
      if let sliderView = data.view {
        sliderView.setValue(value)
      }
    }
  }
}
