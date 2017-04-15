//
//  TRIGameSceneLayout.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import Foundation

class TRIGameSceneLayout: NSObject {

    static var openCardOffset: CGFloat = 10.0
    static var deckPosition: CGPoint = CGPoint(x:40, y:50)
    static var tripeakOffsetY: CGFloat = 60.0
    static var tripeakOffsetBetweenCards: CGFloat = 2.0
    static var cardSizeMultiplier = 0.75
    static var cardSize: CGSize = CGSize(
        width: 77 * cardSizeMultiplier,
        height: 104 * cardSizeMultiplier
    )
}
