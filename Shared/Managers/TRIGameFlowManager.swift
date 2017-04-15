//
//  TRIGameFlowManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-15.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameFlowManager: NSObject {
    
    private weak var gameScene: TRIGameScene?
    
    var peakCards: [TRICard] {
        get {
            let peak = leftPeak + centerPeak + rightPeak
            return peak.sorted(by: { (cardA: TRICard, cardB:TRICard) -> Bool in
                return cardA.position.y < cardB.position.y
            })
        }
    }
    
    var leftPeak: [TRICard] {
        get {
            return self.gameScene!.leftPeak
        }
        set {
            self.gameScene!.leftPeak = newValue
        }
    }
    
    var centerPeak: [TRICard] {
        get {
            return self.gameScene!.centerPeak
        }
        set {
            self.gameScene!.centerPeak = newValue
        }
    }
    
    var rightPeak: [TRICard] {
        get {
            return self.gameScene!.rightPeak
        }
        set {
            self.gameScene!.rightPeak = newValue
        }
    }
    
    init(gameScene: TRIGameScene) {
        super.init()
        self.gameScene = gameScene
    }
    
    func handleTouchStart(point: CGPoint) {
        for card: TRICard in self.peakCards {
            if card.contains(point) {
                card.remove()
                
                // Remove them from the peak
                self.removeCardFromPeak(peak: &self.leftPeak, card: card)
                self.removeCardFromPeak(peak: &self.centerPeak, card: card)
                self.removeCardFromPeak(peak: &self.rightPeak, card: card)
                
                return
            }
        }
    }
    
    private func removeCardFromPeak( peak: inout [TRICard], card: TRICard) {
        if let index = peak.index(of: card) {
            peak.remove(at: index)
        }
    }
}
