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
    SliderControls.create(iiControlsStorage.allArray,
      delegate: self, superview: sliderParentView)
  }

  @IBAction func onDefaultTapped(sender: AnyObject) {
    for data in iiControlsStorage.allArray {
      data.view?.resetToDefault()
    }
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
