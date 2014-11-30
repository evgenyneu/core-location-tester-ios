//
//  SliderDefaults.swift
//  SpringAnimationCALayer
//
//  Created by Evgenii Neumerzhitckii on 1/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

struct SliderDefaults {
  let value: Float
  let minimumValue: Float
  let maximumValue: Float
  var valueNames = [Float:String]()
  var step:Float = 0

  init(value: Float, minimumValue: Float, maximumValue: Float) {
    self.value = value;
    self.minimumValue = minimumValue
    self.maximumValue = maximumValue
  }

  static func set(slider: UISlider, defaults: SliderDefaults) {
    slider.minimumValue = defaults.minimumValue
    slider.maximumValue = defaults.maximumValue
    slider.value = defaults.value
  }
}
