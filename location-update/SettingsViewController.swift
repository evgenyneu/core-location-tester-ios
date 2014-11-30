//
//  SettingsViewController.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController, SliderControllerDelegate {


  @IBOutlet weak var sliderParentView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    sliderParentView.backgroundColor = nil
    createControls()

    disableLeftSwipeGesture()
  }

  private func disableLeftSwipeGesture() {
    navigationController?.interactivePopGestureRecognizer.enabled = false
  }

  private func createControls() {
    var previousControl:SliderControllerView? = nil

    for data in AppDelegate.current.allControlsData.values {
      let control = SliderControllerView(type: data.type,
        defaults: data.defaults, delegate: self)

      data.view = control

      sliderParentView.addSubview(control)

      SettingsViewController.layoutControl(control, previous: previousControl)
      previousControl = control
    }
  }

  private class func layoutControl(control: UIView, previous: UIView?) {
    control.setTranslatesAutoresizingMaskIntoConstraints(false)

    if let currentPrevious = previous {
      iiLayout.stackVertically(currentPrevious, viewNext: control, margin: 15)
    } else {
      if let currentSuperview = control.superview {
        iiLayout.alignTop(control, anotherView: currentSuperview)
      }
    }

    iiLayout.fullWidthInParent(control)
  }

  override func willMoveToParentViewController(parent: UIViewController?) {
    super.willMoveToParentViewController(parent)

    if parent == nil {
      AppDelegate.current.location.restartUpdatingLocation()
    }
  }
}

// SliderControllerDelegate
// -------------------------

typealias SliderControllerDelegate_implementation = SettingsViewController

extension SliderControllerDelegate_implementation {
  func sliderControllerDelegate_OnChangeEnded() {

  }
}
