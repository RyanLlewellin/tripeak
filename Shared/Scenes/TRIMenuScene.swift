//
//  TRIMenuScene.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-07-11.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import SpriteKit

class TRIMenuScene: SKScene {

    private weak var background: TRIBackground?
    private weak var btnTimed: TRIWireButton?
    private weak var btnRelaxed: TRIWireButton?
    
    override func didMove(to view: SKView) {
        self.setupBackground()
        self.setupInterface()
    }
    
    private func setupButtons() {
        
        let size = CGSize(
            width: self.size.width * 0.3,
            height: self.size.height * 0.15
        )
        
        let btnTimed = TRIWireButton(
            color: SKColor.white,
            size: size,
            title: "2-Minute Time Limit",
            image: "clock"
        )
        
        self.addChild(btnTimed)
        btnTimed.position = CGPoint(
            x: self.size.width / 2 - size.width / 2 - 30,
            y: self.size.height / 2
        )
        
        btnTimed.addTarget(self, selector: #selector(TRIMenuScene.timedModeGame))
        btnTimed.isUserInteractionEnabled = true
        btnTimed.label.fontSize = TRIMenuSceneLayout.buttonFontSize
        btnTimed.updateLabelPosition()
        self.btnTimed = btnTimed
        
        
        
        let btnRelaxed = TRIWireButton(
            color: SKColor.white,
            size: size,
            title: "No Time Limit",
            image: "infinity"
        )
        
        self.addChild(btnRelaxed)
        btnRelaxed.position = CGPoint(
            x: self.size.width / 2 + size.width / 2 + 30,
            y: self.size.height / 2
        )
        
        btnRelaxed.addTarget(self, selector: #selector(TRIMenuScene.relaxedModeGame))
        btnRelaxed.isUserInteractionEnabled = true
        btnRelaxed.label.fontSize = TRIMenuSceneLayout.buttonFontSize
        btnRelaxed.updateLabelPosition()
        self.btnRelaxed = btnRelaxed
    }
    
    func relaxedModeGame() {
        print("Relax")
    }
    
    func timedModeGame() {
        print("Timed")
    }
    
    private func setupInterface() {
        
        self.setupLogo()
        self.setupButtons()
    }
    
    private func setupLogo() {
        
        let lblTitle = TRIUnderlinedLabelNode(
            text: "Tripeak Solitaire",
            borderHeight: TRIMenuSceneLayout.titleBorderHeight,
            underlinedWidthPercentage: 0.5
        )
        lblTitle.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height - TRIMenuSceneLayout.titleYOffset
        )
        lblTitle.fontSize = TRIMenuSceneLayout.titleFontSize
        self.addChild(lblTitle)
        
        let suits = SKSpriteNode(imageNamed: "suits")
        suits.position = CGPoint(
            x: lblTitle.position.x,
            y: lblTitle.position.y + TRIMenuSceneLayout.suitsOffset
        )
        suits.size = CGSize(
            width: suits.size.width * 0.5,
            height: suits.size.height * 0.5
        )
        self.addChild(suits)
    }
    
    private func setupBackground() {
        let background = TRIBackground(size: self.size)
        self.addChild(background)
        self.background = background
    }
    
    
}
