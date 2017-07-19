//
//  TRIGameSceneLayout.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import Foundation

class TRIGameSceneLayout: TRIBaseGameLayout {
    
    static var timerHeight: CGFloat = 5.0
    static var hudHeight: CGFloat = 40.0
    static var hudFont: String = Fonts.HelveticaNeueLight.rawValue
    static var hudFontSize: CGFloat = 21.0
    static var openCardOffset: CGFloat = 10.0
    static var deckPosition: CGPoint = CGPoint(x:40, y:50)
    static var tripeakOffsetY: CGFloat = 60.0
    static var tripeakOffsetBetweenCards: CGFloat = 2.0
    static var cardSizeMultiplier = 0.75
    static var cardSize: CGSize = CGSize(
        width: 77 * cardSizeMultiplier,
        height: 104 * cardSizeMultiplier
    )
    
    override class func setupIphone6p() {
        deckPosition = CGPoint(x: 50, y: 60)
        cardSizeMultiplier = 0.8
        tripeakOffsetY = 75
        tripeakOffsetBetweenCards = 3.0
        openCardOffset = 10
        hudHeight = 40
        timerHeight = 8
    }
    
    override class func setupIphone5() {
        deckPosition = CGPoint(x: 40, y: 45)
        cardSizeMultiplier = 0.65
        tripeakOffsetY = 55
        tripeakOffsetBetweenCards = 2.0
        openCardOffset = 8
        hudHeight = 40
        timerHeight = 4
    }
    
    override class func setupIphone4OrLess() {
        deckPosition = CGPoint(x: 40, y: 45)
        cardSizeMultiplier = 0.55
        tripeakOffsetY = 60
        tripeakOffsetBetweenCards = 1.0
        openCardOffset = 6
        hudHeight = 40
        timerHeight = 5
    }
    
    override class func setupIpad() {
        deckPosition = CGPoint(x: 100, y: 100)
        cardSizeMultiplier = 1.2
        tripeakOffsetY = 140
        tripeakOffsetBetweenCards = 3.0
        openCardOffset = 10
        hudHeight = 50
        timerHeight = 10
    }
}
