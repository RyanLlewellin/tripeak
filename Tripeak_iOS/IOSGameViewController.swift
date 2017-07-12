//
//  GameViewController.swift
//  Tripeak_iOS
//
//  Created by Ryan Llewellin on 12/30/15.
//  Copyright (c) 2015 ModernGames. All rights reserved.
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
        let gameScene = TRIMenuScene(
          size: view.frame.size
        )
        view.presentScene(gameScene)
      }
    }
  }
  
  override var prefersStatusBarHidden : Bool {
    return true
  }
  
}
