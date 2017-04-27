//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by Ryan Llewellin on 12/30/15.
//  Copyright (c) 2015 ModernGames. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
    
    private var gameOverOverlay: TRIGameOverOverlay?
    private var gameSetupManager: TRIGameSetupManager?
    private var gameFlowManager: TRIGameFlowManager?
    var leftPeak: [TRICard] = []
    var centerPeak: [TRICard] = []
    var rightPeak: [TRICard] = []
    var cardDeckGraphics: [TRICard] = []
    weak var currentCard: TRICard?
    var state: TRIGameState = .WillStart
  
    override func didMove(to view: SKView) {
        
        TRIHighScoreManager.instance.reset()
        
        let gameSetupManager = TRIGameSetupManager(gameScene: self)
        self.gameSetupManager = gameSetupManager
        self.gameSetupManager!.setup()
        self.gameFlowManager = TRIGameFlowManager(gameScene: self)
        
        self.setupInterface()
        self.setupOverlays()
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
    
    private func setupOverlays() {
        let overlay = TRIGameOverOverlay(withSize: self.size)
        overlay.zPosition = 99999 // always at the top
        
        self.addChild(overlay)
        self.gameOverOverlay = overlay
    }
    
    func startGameWithCurrentCard(card: TRICard) {
        self.currentCard = card
        self.state = .Started
    }
    
    func gameOver(message: String) {
        print("Game over")
        
        let subTitle = "Score: \(TRIHighScoreManager.instance.formattedScore)"
        self.gameOverOverlay!.show(withTitle: message, subTitle: subTitle) { () -> Void in
            self.state = .Ended
        }
        
        self.state = .WillEnd
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch!.location(in: self)
        
        if self.state == .Started {
            self.gameFlowManager!.handleTouchStart(point: point)
            return
        }
        
        if self.state == .Ended {
            let gameScene = TRIGameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
            self.touchesBegan(touches, with: event)
        #endif
    }
}
