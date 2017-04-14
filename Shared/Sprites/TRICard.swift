//
//  TRICard.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICard: SKNode {

    var cardModel: TRICardModel?
    weak var front: SKSpriteNode?
    var size: CGSize = TRIGameSceneLayout.cardSize
    
    override init() {
        super.init()
    }
    
    init(cardModel: TRICardModel) {
        super.init()
        self.cardModel = cardModel
        let front = SKSpriteNode(imageNamed: cardModel.asset)
        front.size = size
        self.addChild(front)
        self.front = front
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
