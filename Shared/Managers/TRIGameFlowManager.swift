//
//  TRIGameFlowManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-15.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameFlowManager: NSObject {
    
    private var debug: Bool = false
    
    private var leftPeakCompleted: Bool = false
    private var centerPeakCompleted: Bool = false
    private var rightPeakCompleted: Bool = false
    
    private weak var gameScene: TRIGameScene?
    
    var currentCard: TRICard? {
        get {
            return self.gameScene!.currentCard
        }
        set {
            self.gameScene!.currentCard = newValue
        }
    }
    
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
        
        #if DEBUG
            self.debug = true
        #endif
    }
    
    func handleTouchStart(point: CGPoint) {
        for card: TRICard in self.peakCards {
            if card.contains(point) && card.clickable {
                if self.validateCardAgainstCurrentCard(cardModel: card.cardModel!) || debug {
                    
                    TRIHighScoreManager.instance.cardCleared()
                    
                    card.remove()
                    
                    let position = CGPoint(
                        x: self.currentCard!.finalPosition!.x + TRIGameSceneLayout.openCardOffset,
                        y: self.currentCard!.finalPosition!.y
                    )
                    card.finalPosition = position
                    
                    let animation = SKAction.move(to: position, duration: 0.2)
                    animation.timingMode = .easeOut
                    card.run(animation)
                    card.zPosition = self.currentCard!.zPosition + 1
                    
                    self.gameScene!.currentCard = card
                    
                    // Remove them from the peak
                    self.removeCardFromPeak(peak: &self.leftPeak, card: card)
                    self.removeCardFromPeak(peak: &self.centerPeak, card: card)
                    self.removeCardFromPeak(peak: &self.rightPeak, card: card)
                    
                    self.checkPeaks()
                    self.checkAvailableMoves()
                }
                return
            }
        }
        
        let optionalTopCard = self.gameScene!.cardDeckGraphics.last
        if let topCard = optionalTopCard {
            if topCard.contains(point) {
                let position = CGPoint(
                    x: self.currentCard!.finalPosition!.x + TRIGameSceneLayout.openCardOffset,
                    y: self.currentCard!.finalPosition!.y
                )
                topCard.finalPosition = position
                
                let animation = SKAction.move(to: position, duration: 0.2)
                animation.timingMode = .easeOut
                topCard.flip()
                topCard.run(animation)
                
                topCard.zPosition = self.currentCard!.zPosition + 1
                self.gameScene!.currentCard = topCard
                
                let cardIndex = self.gameScene!.cardDeckGraphics.index(of: topCard)
                self.gameScene!.cardDeckGraphics.remove(at: cardIndex!)
                self.checkAvailableMoves()
            }
        }
    }
    
    private func checkPeaks() {
        if self.gameScene!.leftPeak.count == 0 && !self.leftPeakCompleted {
            self.leftPeakCompleted = true
            TRIHighScoreManager.instance.peakCleared()
        }
        
        if self.gameScene!.centerPeak.count == 0 && !self.centerPeakCompleted {
            self.centerPeakCompleted = true
            TRIHighScoreManager.instance.peakCleared()
        }
        
        if self.gameScene!.rightPeak.count == 0 && !self.rightPeakCompleted {
            self.rightPeakCompleted = true
            TRIHighScoreManager.instance.peakCleared()
        }
        
        if (self.leftPeakCompleted &&
            self.centerPeakCompleted &&
            self.rightPeakCompleted) {
            
            print("Game completed")
            TRIHighScoreManager.instance.gameClearedWithRemainingCard(
                remainingCards: self.gameScene!.cardDeckGraphics.count
            )
            self.gameScene?.gameOver(message: "Nice Game")
        }
    }
    
    private func checkAvailableMoves() {
        if(self.gameScene!.cardDeckGraphics.count == 0) {
            var canContinue = false
            
            var arr = self.peakCards
            arr = arr.filter({ (card: TRICard) -> Bool in
                return card.clickable
            })
            
            if arr.count == 0 {
                return
            }
            
            for card: TRICard in arr {
                let validMove = self.validateCardAgainstCurrentCard(cardModel: card.cardModel!)
                if(validMove) {
                    canContinue = true
                    break
                }
            }
            
            if(!canContinue){
                print("No valid moves left")
                self.gameScene!.gameOver(message: "No moves left!")
            }
        }
    }
    
    private func validateCardAgainstCurrentCard(cardModel: TRICardModel) -> Bool {
        
        if cardModel.rank.rawValue == currentCard!.cardModel!.rank.rawValue + 1 {
            return true
        }
        
        if cardModel.rank.rawValue == currentCard!.cardModel!.rank.rawValue - 1 {
            return true
        }
        
        if currentCard!.cardModel!.rank == .Ace && cardModel.rank == .King {
            return true
        }
        
        if currentCard!.cardModel!.rank == .King && cardModel.rank == .Ace {
            return true
        }
        
        return false
    }
    
    private func removeCardFromPeak( peak: inout [TRICard], card: TRICard) {
        if let index = peak.index(of: card) {
            peak.remove(at: index)
        }
    }
}
