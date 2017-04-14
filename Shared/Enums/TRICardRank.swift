//
//  TRICardRank.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import Foundation

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func stringValue() -> String {
        switch self {
        case .Ace:
            return "A"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        default:
            return String(self.rawValue)
        }
    }
}
