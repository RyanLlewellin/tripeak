//
//  GameViewController.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import UIKit
import SpriteKit

class IOSGameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillLayoutSubviews() {
    if let view = self.view as? SKView {
      if view.scene == nil {
        let gameScene = TRIGameScene(
          size: view.frame.size
        )
        view.presentScene(gameScene)
      }
    }
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
}
