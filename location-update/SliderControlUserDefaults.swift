//
//  SliderControlUserDefaults.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation


class SliderControlUserDefaults {
  class func keyName(type: ControlType) -> String {
    return "Slider Value '\(type.rawValue)'"
  }

  class func value(type: ControlType) -> Float? {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    if let currentValue = userDefaults.objectForKey(keyName(type)) as? Float {
      return currentValue
    }
    return nil
  }

  class func saveValue(value: Float, type: ControlType) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setFloat(value, forKey: keyName(type))
  }
}
