//
//  TRIParallaxEffect.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 1/8/16.
//  Copyright © 2016 ModernGames. All rights reserved.
//

import UIKit

protocol TRIParallaxEffectDelegate {
  func keyPathsAndRelativeValuesForViewerOffset(_ values: [String : AnyObject]?)
}

class TRIParallaxEffect: UIInterpolatingMotionEffect {
  
  var delegate: TRIParallaxEffectDelegate?
  
  override func keyPathsAndRelativeValues(
    forViewerOffset viewerOffset: UIOffset) -> [String : Any]? {
      
      let values = super.keyPathsAndRelativeValues(
        forViewerOffset: viewerOffset
      )
      if let delegate = self.delegate {
        delegate.keyPathsAndRelativeValuesForViewerOffset(values! as [String : AnyObject])
      }
      
      return values
  }
  
}
