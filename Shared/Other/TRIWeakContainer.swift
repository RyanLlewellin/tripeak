//
//  TRIWeakContainer.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/7/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

class TRIWeakContainer<T: AnyObject> {
  
  weak var value: T?
  
  init (value: T) {
    self.value = value
  }
  
}
