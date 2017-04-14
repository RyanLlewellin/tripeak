//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
  
    override func didMove(to view: SKView) {
        let model = TRICardModel(suit: .Clubs, rank: .Ace)
        let card = TRICard(cardModel: model)
        card.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        self.addChild(card)
    }
}
