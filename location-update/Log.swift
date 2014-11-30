//
//  MyLogger.swift
//  Geo Regions Test
//
//  Created by Evgenii Neumerzhitckii on 21/06/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Log {
  private var textView: UITextView?

  init() {
  }

  func setTextView(textView: UITextView) {
    self.textView = textView
  }

  private func setText(text: String) {
    if let currentTextView = textView {
      currentTextView.text = text
    }
  }

  private var text: String {
    if let currentTextView = textView {
      return currentTextView.text
    }

    return ""
  }

  func add(text: String){
    iiQ.main {
      self.setText("\(self.text)\n\(self.currentTime) \(text)")
    }
  }

  class func coordToString(location: CLLocation) -> String {
    let lat = NSString(format: "%.6f", location.coordinate.latitude)
    let lon = NSString(format: "%.6f", location.coordinate.longitude)

    return "\(lat), \(lon)"
  }

  private var currentTime: String {
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.timeStyle = .ShortStyle
    return formatter.stringFromDate(date)
  }

  func clear() {
    iiQ.main {
      self.setText("")
    }
  }
}
