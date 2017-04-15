//
//  TRIGameSetupManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameSetupManager: NSObject {

    private var cardDeckGraphics: [TRICard] {
        get {
            return self.gameScene!.cardDeckGraphics
        }
        set {
            self.gameScene!.cardDeckGraphics = newValue
        }
    }
    
    private var leftOrderedPeakRows: [[TRICard]] = []
    private var centerOrderedPeakRows: [[TRICard]] = []
    private var rightOrderedPeakRows: [[TRICard]] = []
    
    private var openCards: [TRICard] = []
    private weak var gameScene: TRIGameScene?
    private var cardDeck: [TRICardModel] = []
    
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
    
    init(gameScene: TRIGameScene){
        super.init()
        self.gameScene = gameScene
    }
    
    func setup() {
        self.createDeck()
        self.setupTriPeak()
        self.splitPeaksIntoRows()
        self.setupCardManagers()
        self.deckSetup()
        self.beginGame()
    }
    
    func deckSetup() {
        for i in 0..<self.cardDeck.count {
            let card = TRICard(cardModel: self.getRandomCard())
            card.position = CGPoint(
                x: TRIGameSceneLayout.deckPosition.x,
                y: TRIGameSceneLayout.deckPosition.y + CGFloat(i) / 5
            )
            self.gameScene!.addChild(card)
            self.cardDeckGraphics.append(card)
        }
    }
    
    private func beginGame() {
        let waitAction = SKAction.wait(forDuration: 0.2)
        self.gameScene!.run(waitAction, completion: {() -> Void in
            self.openUpCurrentCard()
        })
    }
    
    private func openUpCurrentCard() {
        let card = self.cardDeckGraphics.last!
        let position = CGPoint(
            x: TRIGameSceneLayout.deckPosition.x + card.size.width + 15,
            y: TRIGameSceneLayout.deckPosition.y
        )
        card.finalPosition = position
        
        let animation = SKAction.move(to: position, duration: 0.2)
        animation.timingMode = .easeOut
        card.run(animation, completion: {() -> Void in
            card.flip()
            card.zPosition = 2000
            self.gameScene!.currentCard = card
        })
        
        let cardIndex = self.cardDeckGraphics.index(of: card)
        self.cardDeckGraphics.remove(at: cardIndex!)
    }
    
    private func setupCardManagers() {
        self.setupManagersForPeak(peakRows: leftOrderedPeakRows)
        self.setupManagersForPeak(peakRows: centerOrderedPeakRows)
        self.setupManagersForPeak(peakRows: rightOrderedPeakRows)
    }
    
    func setupManagersForPeak(peakRows: [[TRICard]]) {
        var row: Int = 0
        for currentRow: [TRICard] in peakRows {
            let isLastRow: Bool = (row == peakRows.count - 1)
            if(!isLastRow) {
                var indexOfCurrentCard: Int = 0
                for currentCard: TRICard in currentRow {
                    let leftBlockingCard: TRICard = peakRows[row + 1][indexOfCurrentCard]
                    let rightBlockingCard: TRICard = peakRows[row + 1][indexOfCurrentCard + 1]
                    
                    let manager = TRICardManager(
                        managingCard: currentCard,
                        leftBlockingCard: leftBlockingCard,
                        rightBlockingCard: rightBlockingCard
                    )
                    
                    currentCard.manager = manager
                    
                    indexOfCurrentCard += 1
                }
            }
            row += 1
        }
    }
    
    func createDeck() {
        for suit: Suit in Suit.allValues {
            for rank: Rank in Rank.allValues {
                self.cardDeck.append(
                    TRICardModel(suit: suit, rank: rank)
                )
            }
        }
    }
    
    func getRandomCard() -> TRICardModel {
        let index = UInt32(self.cardDeck.count)
        let randomIndex: Int = Int(arc4random_uniform(index))
        let retVal = self.cardDeck[randomIndex]
        self.cardDeck.remove(at: randomIndex)
        return retVal
    }
    
    func setupPeakWithTopPositionAtPoint(point: CGPoint) -> [TRICard] {
        let dummyCard = TRICard()
        let offset = TRIGameSceneLayout.tripeakOffsetBetweenCards
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        // Top card
        x = point.x
        y = point.y - dummyCard.size.height / 2 // anchor point is in the middle so divide by 2
        let topCard = self.createCard(x: x, y: y)
        
        // Center 2 cards
        x = topCard.position.x - topCard.size.width / 2 - offset
        y = topCard.position.y - topCard.size.height / 2
        let centerLeftCard = self.createCard(x: x, y: y)
        
        x = topCard.position.x + topCard.size.width / 2 + offset
        y = topCard.position.y - topCard.size.height / 2
        let centerRightCard = self.createCard(x: x, y: y)
        
        // Bottom 3 cards
        x = centerLeftCard.position.x - centerLeftCard.size.width / 2 - offset
        y = centerLeftCard.position.y - centerLeftCard.size.height / 2
        let bottomLeftCard = self.createCard(x: x, y: y)
        
        x = topCard.position.x
        y = centerLeftCard.position.y - centerLeftCard.size.height / 2
        let bottomCenterCard = self.createCard(x: x, y: y)
        
        x = centerRightCard.position.x + centerLeftCard.size.width / 2 + offset
        y = centerLeftCard.position.y - centerLeftCard.size.height / 2
        let bottomRightCard = self.createCard(x: x, y: y)
        
        return [
             topCard,
             centerLeftCard, centerRightCard,
             bottomLeftCard, bottomCenterCard, bottomRightCard
        ]
    }
    
    private func createCard(x: CGFloat, y: CGFloat) -> TRICard {
        let card = TRICard(cardModel: self.getRandomCard())
        card.position = CGPoint(x: x, y: y)
        self.gameScene!.addChild(card)
        return card
    }
    
    func setupTriPeak() {
        let offsetY = self.gameScene!.size.height - TRIGameSceneLayout.tripeakOffsetY
        let centerX = self.gameScene!.size.width / 2
        
        let dummyCard = TRICard()
        var leftX = centerX - dummyCard.size.width * 3
        leftX -= TRIGameSceneLayout.tripeakOffsetBetweenCards * 6
        
        var rightX = centerX + dummyCard.size.width * 3
        rightX += TRIGameSceneLayout.tripeakOffsetBetweenCards * 6
        
        self.centerPeak = self.setupPeakWithTopPositionAtPoint(
            point: CGPoint(x: centerX, y: offsetY)
        )
        
        self.leftPeak = self.setupPeakWithTopPositionAtPoint(
            point: CGPoint(x: leftX, y: offsetY)
        )
        
        self.rightPeak = self.setupPeakWithTopPositionAtPoint(
            point: CGPoint(x: rightX, y: offsetY)
        )
        
        self.setupOpenCards()
    }
    
    private func splitPeaksIntoRows() {
        leftOrderedPeakRows = self.splitPeakIntoRows(peak: self.leftPeak)
        centerOrderedPeakRows = self.splitPeakIntoRows(peak: self.centerPeak)
        rightOrderedPeakRows = self.splitPeakIntoRows(peak: self.rightPeak)
    }
    
    private func splitPeakIntoRows(peak: [TRICard]) -> [[TRICard]] {
        var currentRow = 0
        var cardsOnCurrentRow = 1
        var currentCardNum = 0
        
        var peakRows: [[TRICard]] = [[]]
        
        for card: TRICard in peak {
            if currentCardNum == cardsOnCurrentRow { // move to next row
                peakRows.append([])
                currentCardNum = 0
                currentRow += 1
                cardsOnCurrentRow += 1
            }
            peakRows[currentRow].append(card)
            currentCardNum += 1
        }
        return peakRows
    }
    
    private func setupOpenCards() {
        let lastCard = self.rightPeak.last!
        let yPos = lastCard.position.y - lastCard.size.height / 2
        var xPos = lastCard.position.x + lastCard.size.width / 2
        
        for _ in 0...9 {
            let openCard = self.createCard(x: xPos, y: yPos)
            openCard.open = true
            xPos -= TRIGameSceneLayout.tripeakOffsetBetweenCards * 2
            xPos -= lastCard.size.width
            self.openCards.append(openCard)
        }
        // we started from the right so reverse
        self.openCards = self.openCards.reversed()
        
        self.addCardsToPeak(peak: &self.leftPeak, offset: 0)
        self.addCardsToPeak(peak: &self.centerPeak, offset: 3)
        self.addCardsToPeak(peak: &self.rightPeak, offset: 6)
    }
    
    private func addCardsToPeak( peak: inout [TRICard], offset: Int) {
        let numberOfCards = 4
        for i in offset..<offset + numberOfCards {
            let openCard = openCards[i]
            peak.append(openCard)
        }
    }
}
