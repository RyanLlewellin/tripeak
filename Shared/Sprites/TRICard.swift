//
//  TRICard.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICard: SKNode {

    var open: Bool = false {
        didSet {
            self.handleOpenClosed()
        }
    }
    
    var cardModel: TRICardModel?
    
    weak var front: SKSpriteNode?
    weak var back: SKSpriteNode?
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
        
        let back = SKSpriteNode(imageNamed: self.cardBackWithColor(color: .Red, type: .Type4))
        back.size = size
        self.addChild(back)
        self.back = back
        
        self.handleOpenClosed()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // overrides print statement
    override var description: String {
        return "\(self.cardModel!.rank) of \(self.cardModel!.suit)"
    }
    
    private func cardBackWithColor(color: CardBackColor, type: CardBackType) -> String {
        return "cardBack_" + color.stringValue() + type.stringValue()
    }
    
    private func handleOpenClosed() {
        if open {
            self.front!.isHidden = false
            self.back!.isHidden = true
        }
        else {
            self.front!.isHidden = true
            self.back!.isHidden = false
        }
    }
}
