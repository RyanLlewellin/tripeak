//
//  TRIHighScoreManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-20.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

protocol TRIHighscoreManagerDelegate: NSObjectProtocol {
    func scoreUpdated(score: Int)
}

class TRIHighScoreManager: NSObject {
    
    private var subscribers: [TRIHighscoreManagerDelegate] = []

    static var instance = TRIHighScoreManager()
    var formattedScore: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter.string(
                from: NSNumber(integerLiteral: self.score)
            )!
        }
    }
    
    var inverseMultiplier: CGFloat = 0
    var score: Int = 0 {
        didSet {
            print("Score: \(score)")
            self.notifySubscribers()
        }
    }
    
    func cardCleared() {
        print("Card Cleared")
        self.score += self.multiplied(number: 125)
    }
    
    func peakCleared() {
        print("Peak Cleared")
        self.score += self.multiplied(number: 1250)
    }
    
    func gameClearedWithRemainingCard(remainingCards: Int) {
        print("Game Cleared with \(remainingCards) remaining cards")
        self.score += self.multiplied(number: 5000)
        if(remainingCards > 0) {
            for i in 1...remainingCards {
                let num = Double(i) / 20.0
                self.score += self.multiplied(number: num * 250)
            }
        }
    }
    
    func reset() {
        self.subscribers = []
        self.inverseMultiplier = 0
        self.score = 0
    }
    
    private func multiplied(number: Double) -> Int {
        let num = number + number * Double(1 - inverseMultiplier)
        return Int(round(num / 5) * 5) // make sure rounded to nearest 5
    }
    
    func addSubscriber(subscriber: TRIHighscoreManagerDelegate) {
        self.subscribers.append(subscriber)
    }
    
    private func notifySubscribers() {
        for subscriber: TRIHighscoreManagerDelegate in subscribers {
            subscriber.scoreUpdated(score: score)
        }
    }
    
}
