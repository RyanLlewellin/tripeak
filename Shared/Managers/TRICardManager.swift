//
//  TRICardManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-15.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICardManager: NSObject, TRICardDelegate {

    private var leftBlockingCard: TRICard?
    private var rightBlockingCard: TRICard?
    private var managingCard: TRICard?
    
    init(managingCard: TRICard, leftBlockingCard: TRICard, rightBlockingCard: TRICard) {
        super.init()
        
        self.leftBlockingCard = leftBlockingCard
        self.rightBlockingCard = rightBlockingCard
        self.managingCard = managingCard
        
        self.leftBlockingCard?.addSubscriber(subscriber: self)
        self.rightBlockingCard?.addSubscriber(subscriber: self)
    }
    
    func cardStatusChanged(card: TRICard) {
        self.update()
    }
    
    private func update() {
        if(leftBlockingCard!.removed && rightBlockingCard!.removed) {
            managingCard!.open = true
        }
    }
}
