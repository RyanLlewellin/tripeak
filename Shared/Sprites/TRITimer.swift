//
//  TRITimer.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-07-17.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import SpriteKit

class TRITimer: SKNode {

    private weak var background: SKSpriteNode?
    private weak var foreground: SKSpriteNode?
    private var pct: CGFloat = 0.0
    
    var percentage: CGFloat {
        get {
            return self.pct
        }
    }
    
    var size: CGSize = CGSize.zero
    
    convenience init(size: CGSize) {
        self.init()
        self.size = size
        self.setup()
    }
    
    func setup() {
        let background = SKSpriteNode(
            color: SKColor.black,
            size: size
        )
        background.alpha = 0.3
        background.anchorPoint = CGPoint(
            x: 0,
            y: 1
        )
        self.addChild(background)
        self.background = background
        
        let foreground = SKSpriteNode(
            color: SKColor.white,
            size: size
        )
        foreground.anchorPoint = CGPoint(
            x: 0,
            y: 1
        )
        self.addChild(foreground)
        self.foreground = foreground
    }
    
    func updateWithPercentage(percentage: CGFloat){
        self.pct = percentage
        let xscale = 1 - percentage
        let action = SKAction.scaleX(to: xscale, duration: 0.1)
        self.foreground?.run(action)
    }
}
