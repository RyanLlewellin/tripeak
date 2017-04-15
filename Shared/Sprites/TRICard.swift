//
//  TRICard.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

protocol TRICardDelegate {
    func cardStatusChanged(card: TRICard)
}

class TRICard: SKNode {
    
    var manager: TRICardManager?
    
    var finalPosition: CGPoint?
    
    var clickable: Bool = true
    var removed: Bool = false {
        didSet {
            if removed {
                self.clickable = false
            }
        }
    }

    var open: Bool = false {
        didSet {
            self.handleOpenClosed()
        }
    }
    
    var cardModel: TRICardModel?
    
    private var subscribers: [TRICardDelegate] = []
    
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
            self.clickable = true
            self.front!.isHidden = false
            self.back!.isHidden = true
        }
        else {
            self.clickable = false;
            self.front!.isHidden = true
            self.back!.isHidden = false
        }
    }
    
    func remove() {
        self.removeFromParent()
        self.removed = true
        self.notifySubscribers()
    }
    
    func addSubscriber(subscriber: TRICardDelegate) {
        self.subscribers.append(subscriber)
    }
    
    func notifySubscribers() {
        for subscriber: TRICardDelegate in self.subscribers {
            subscriber.cardStatusChanged(card: self)
        }
    }
    
    private func updateAnimationWithScale(scale: CGFloat, element: SKNode) {
        element.xScale = scale
        element.yScale = scale
        let scaleAction = SKAction.scale(to: 1, duration: 0.2)
        element.run(scaleAction)
        
    }
    
    func flip() {
        if self.open {
            return
        }
        self.clickable = true
        
        let scaleXAction = SKAction.scaleX(to: 0.05, duration: 0.225)
        let scaleYAction = SKAction.scaleY(to: 1.3, duration: 0.225)
        
        let groupAction = SKAction.group([scaleXAction, scaleYAction])
        self.back!.run(groupAction, completion: {() -> Void in
            self.open = true
            self.updateAnimationWithScale(scale: 1.25, element:self.front!)
        })
    }
}





