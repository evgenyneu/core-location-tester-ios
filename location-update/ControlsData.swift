//
//  ControlsData.swift
//  SpringAnimationCALayer
//
//  Created by Evgenii Neumerzhitckii on 2/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class ControlData {
  let type: ControlType
  let defaults: SliderDefaults
  let step:Float = 0
  var view: SliderControllerView? = nil

  init(type: ControlType, defaults: SliderDefaults, step: Float=0) {
    self.type = type
    self.defaults = defaults
    self.step = step
  }
}
