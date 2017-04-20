//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
    
    private var gameSetupManager: TRIGameSetupManager?
    private var gameFlowManager: TRIGameFlowManager?
    var leftPeak: [TRICard] = []
    var centerPeak: [TRICard] = []
    var rightPeak: [TRICard] = []
    var cardDeckGraphics: [TRICard] = []
    weak var currentCard: TRICard?
  
    override func didMove(to view: SKView) {
        
        TRIHighScoreManager.instance.reset()
        
        let gameSetupManager = TRIGameSetupManager(gameScene: self)
        self.gameSetupManager = gameSetupManager
        self.gameSetupManager!.setup()
        self.gameFlowManager = TRIGameFlowManager(gameScene: self)
        
        self.setupInterface()
    }
    
    private func setupInterface() {
        let hudBG = SKSpriteNode(
            color: SKColor.black.withAlphaComponent(0.2),
            size: CGSize(width: self.size.width, height: TRIGameSceneLayout.hudHeight)
        )
        
        hudBG.position = CGPoint (
            x: self.size.width / 2,
            y: self.size.height - hudBG.size.height / 2
        )
        
        self.addChild(hudBG)
        
        let highscoreElement = TRIHighscoreElement()
        highscoreElement.position = hudBG.position
        TRIHighScoreManager.instance.addSubscriber(subscriber: highscoreElement)
        self.addChild(highscoreElement)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch!.location(in: self)
        self.gameFlowManager!.handleTouchStart(point: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
            self.touchesBegan(touches, with: event)
        #endif
    }
}
