//
//  TRIBack.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-14.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import Foundation

enum CardBackColor: String {
    case Blue
    case Green
    case Red
    
    func stringValue() -> String {
        return self.rawValue.lowercased()
    }
}

enum CardBackType: Int {
    case Type1 = 1
    case Type2
    case Type3
    case Type4
    case Type5
    
    func stringValue() -> String {
        return String(self.rawValue)
    }
}
