//
//  GameViewController.swift
//  Tripeak_iOS
//
//  Created by Ryan Llewellin on 12/30/15.
//  Copyright (c) 2015 ModernGames. All rights reserved.
//

import UIKit
import SpriteKit

class IOSGameViewController: UIViewController, TRIParallaxEffectDelegate {
  
    private var xOffset: Double = 0
    private var yOffset: Double = 0
    private var currentScene: SKScene? {
        get {
            let view = self.view as! SKView
            return view.scene
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let horizontalMotionEffect = TRIParallaxEffect(
            keyPath: "horizontalMotion",
            type: .tiltAlongHorizontalAxis
        )
        horizontalMotionEffect.minimumRelativeValue = -1
        horizontalMotionEffect.maximumRelativeValue = 1
        horizontalMotionEffect.delegate = self
        
        let verticalMotionEffect = TRIParallaxEffect(
            keyPath: "verticalMotion",
            type: .tiltAlongVerticalAxis
        )
        verticalMotionEffect.minimumRelativeValue = -1
        verticalMotionEffect.maximumRelativeValue = 1
        verticalMotionEffect.delegate = self

        self.view.addMotionEffect(horizontalMotionEffect)
        self.view.addMotionEffect(verticalMotionEffect)
    }
    
    func keyPathsAndRelativeValuesForViewerOffset(_ values: [String : AnyObject]?){
        if let values = values {
            if let value = values["verticalMotion"] {
                self.yOffset = value as! Double
            }
            if let value = values["horizontalMotion"] {
                self.xOffset = value as! Double
            }
            if let currentScene = self.currentScene {
                currentScene.updateMotion(
                    xVal: self.xOffset,
                    yVal: self.yOffset
                )
            }
        }
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
