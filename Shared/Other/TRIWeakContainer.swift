//
//  TRIWeakContainer.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 1/7/16.
//  Copyright © 2016 ModernGames. All rights reserved.
//

class TRIWeakContainer<T: AnyObject> {
  
  weak var value: T?
  
  init (value: T) {
    self.value = value
  }
  
}
