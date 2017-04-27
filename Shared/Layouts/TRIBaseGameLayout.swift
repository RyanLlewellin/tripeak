//
//  TRIBaseGameLayout.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 1/8/16.
//  Copyright © 2016 ModernGames. All rights reserved.
//

import UIKit

enum TRIBaseGameLayoutDevice: Int {
  case iPhone4OrLess
  case iPhone5
  case iPhone6
  case iPhone6p
  case iPad
}

class TRIBaseGameLayout: NSObject {
  
  class func setup(_ layout: TRIBaseGameLayoutDevice) {
    switch layout {
    case .iPhone4OrLess:
      self.setupIphone4OrLess()
      break
    case .iPhone5:
      self.setupIphone5()
      break
    case .iPhone6:
      self.setupIphone6()
      break
    case .iPhone6p:
      self.setupIphone6p()
      break
    case .iPad:
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
