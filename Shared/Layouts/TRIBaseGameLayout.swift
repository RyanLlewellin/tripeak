//
//  TRIBaseGameLayout.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/8/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import UIKit

enum TRIBaseGameLayoutDevice: Int {
  case IPhone4OrLess
  case IPhone5
  case IPhone6
  case IPhone6p
  case IPad
}

class TRIBaseGameLayout: NSObject {
  
  class func setup(layout: TRIBaseGameLayoutDevice) {
    switch layout {
    case .IPhone4OrLess:
      self.setupIphone4OrLess()
      break
    case .IPhone5:
      self.setupIphone5()
      break
    case .IPhone6:
      self.setupIphone6()
      break
    case .IPhone6p:
      self.setupIphone6p()
      break
    case .IPad:
      self.setupIpad()
      break
    }
  }
  
  class func setupIphone6() {
    print("GameLayout - iPhone 6")
  }
  class func setupIphone6p() {
    print("GameLayout - iPhone 6+")
  }
  class func setupIphone5() {
    print("GameLayout - iPhone 5")
  }
  class func setupIphone4OrLess() {
    print("GameLayout - <= iPhone 4")
  }
  class func setupIpad() {
    print("GameLayout - iPad")
  }
  
}
