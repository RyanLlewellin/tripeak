//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by Ryan Llewellin on 12/30/15.
//  Copyright (c) 2015 ModernGames. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
    
    private weak var background: TRIBackground?
    private var gameOverOverlay: TRIGameOverOverlay?
    private var gameSetupManager: TRIGameSetupManager?
    private var gameFlowManager: TRIGameFlowManager?
    var leftPeak: [TRICard] = []
    var centerPeak: [TRICard] = []
    var rightPeak: [TRICard] = []
    var cardDeckGraphics: [TRICard] = []
    weak var currentCard: TRICard?
    var state: TRIGameState = .WillStart
    private var config: TRIGameConfig?
    private weak var timerBar: TRITimer?
    private var currentTime: CGFloat = 0.0
    private weak var btnPause: TRISimpleButton?
    private weak var pauseOverlay: TRIPauseOverlay?
    
    convenience init(size: CGSize, config: TRIGameConfig) {
        self.init(size: size)
        self.config = config
    }
  
    override func didMove(to view: SKView) {
        
        TRIHighScoreManager.instance.reset()
        
        let gameSetupManager = TRIGameSetupManager(gameScene: self)
        self.gameSetupManager = gameSetupManager
        self.gameSetupManager!.setup()
        self.gameFlowManager = TRIGameFlowManager(gameScene: self)
        
        self.setupBackground()
        self.setupInterface()
        self.setupOverlays()
    }
    
    private func startTimer() {
        
         if self.config!.hasTimer {
            let waitAction = SKAction.wait(forDuration: 0.1)
            let executeAction = SKAction.run({ () -> Void in
                self.currentTime += 0.1
                let percentage = self.currentTime / self.config!.timerSeconds
                self.timerBar?.updateWithPercentage(percentage: percentage)
                TRIHighScoreManager.instance.inverseMultiplier = percentage
                
                if percentage >= 1 {
                    self.gameOver(message: "Time's up!")
                    self.stopTimer()
                }
            })
            
            let sequence = SKAction.sequence([waitAction, executeAction])
            let timerAction = SKAction.repeatForever(sequence)
            self.run(timerAction, withKey: "timer")
        }
    }
    
    private func stopTimer() {
        self.removeAction(forKey: "timer")
    }
    
    private func setupInterface() {
        
        if self.config!.hasTimer {
            let timerBar = TRITimer(
                size: CGSize(
                    width: self.size.width,
                    height: TRIGameSceneLayout.timerHeight
                )
            )
            self.addChild(timerBar)
            timerBar.position = CGPoint(
                x: 0,
                y: self.size.height
            )
            self.timerBar = timerBar
        }
        
        let hudBG = SKSpriteNode(
            color: SKColor.black.withAlphaComponent(0.2),
            size: CGSize(width: self.size.width, height: TRIGameSceneLayout.hudHeight)
        )
        
        var yPos = self.size.height - hudBG.size.height / 2
        if let timerBar = self.timerBar {
            yPos -= timerBar.size.height
        }
        
        hudBG.position = CGPoint (
            x: self.size.width / 2,
            y: yPos
        )
        
        self.addChild(hudBG)
        
        let highscoreElement = TRIHighscoreElement()
        highscoreElement.position = hudBG.position
        TRIHighScoreManager.instance.addSubscriber(subscriber: highscoreElement)
        self.addChild(highscoreElement)
        
        let size = CGSize(
            width: hudBG.size.height,
            height: hudBG.size.height
        )
        let btnPause = TRISimpleButton(
            image: "pause",
            size: size
        )
        
        btnPause.position = CGPoint(
            x: btnPause.size.width * 0.5,
            y: hudBG.position.y
        )
        
        btnPause.isUserInteractionEnabled = true
        btnPause.addTarget(self, selector: #selector(TRIGameScene.pauseGame))
        self.addChild(btnPause)
        self.btnPause = btnPause
    }
    
    func pauseGame() {
        if self.state == .Started {
            self.state = .Paused
            self.stopTimer()
            self.pauseOverlay?.showPauseScreen(closure: nil)
        }
    }
    
    func resumeGame() {
        if self.state == .Paused {
            self.state = .Started
            self.startTimer()
            self.pauseOverlay?.hide(nil)
        }
    }
    
    func goToMenu() {
        let scene = TRIMenuScene(size: self.size)
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
        
    }
    
    private func setupOverlays() {
        let overlay = TRIGameOverOverlay(
            withSize: self.size
        )
        overlay.zPosition = 99999 // always at the top
        
        self.addChild(overlay)
        self.gameOverOverlay = overlay
        
        let pauseOverlay = TRIPauseOverlay(
            withSize: self.size
        )
        pauseOverlay.zPosition = 99999
        pauseOverlay.btnResume?.addTarget(self, selector: #selector(TRIGameScene.resumeGame))
        pauseOverlay.btnMenu?.addTarget(self, selector: #selector(TRIGameScene.goToMenu))
        self.addChild(pauseOverlay)
        self.pauseOverlay = pauseOverlay
    }
    
    private func setupBackground() {
        let background = TRIBackground(size: self.size)
        self.addChild(background)
        self.background = background
    }
    
    func startGameWithCurrentCard(card: TRICard) {
        self.currentCard = card
        self.state = .Started
        self.startTimer()
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
            self.goToMenu()
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if DEBUG
            self.touchesBegan(touches, with: event)
        #endif
    }
}
