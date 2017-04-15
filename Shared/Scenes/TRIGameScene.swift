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
        let gameSetupManager = TRIGameSetupManager(gameScene: self)
        self.gameSetupManager = gameSetupManager
        self.gameSetupManager!.setup()
        self.gameFlowManager = TRIGameFlowManager(gameScene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch!.location(in: self)
        self.gameFlowManager!.handleTouchStart(point: point)
    }
}
