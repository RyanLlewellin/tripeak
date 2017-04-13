//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
  
  override func didMoveToView(view: SKView) {
    let myLabel = SKLabelNode(
      fontNamed: Fonts.HelveticaNeueLight.rawValue
    )
    myLabel.text = "Hello, CodeCaptain!"
    myLabel.fontSize = 45
    myLabel.position = CGPoint(
      x:CGRectGetMidX(self.frame),
      y:CGRectGetMidY(self.frame)
    )
    
    self.addChild(myLabel)

  }
  
}
