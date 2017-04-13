//
//  TRIParallaxEffect.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/8/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import UIKit

protocol TRIParallaxEffectDelegate {
  func keyPathsAndRelativeValuesForViewerOffset(values: [String : AnyObject]?)
}

class TRIParallaxEffect: UIInterpolatingMotionEffect {
  
  var delegate: TRIParallaxEffectDelegate?
  
  override func keyPathsAndRelativeValuesForViewerOffset(
    viewerOffset: UIOffset) -> [String : AnyObject]? {
      
      let values = super.keyPathsAndRelativeValuesForViewerOffset(
        viewerOffset
      )
      if let delegate = self.delegate {
        delegate.keyPathsAndRelativeValuesForViewerOffset(values)
      }
      
      return values
  }
  
}
