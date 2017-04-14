//
//  TRICardModel.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import UIKit

class TRICardModel: NSObject {
    
    var suit: Suit
    var rank: Rank
    var asset: String {
        get {
            return "card" + suit.rawValue + rank.stringValue()
        }
    }

    init(suit: Suit, rank: Rank){
        self.rank = rank
        self.suit = suit
        super.init()
    }
}
