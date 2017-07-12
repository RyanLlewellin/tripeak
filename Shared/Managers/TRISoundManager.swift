//
//  TRISoundManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-07-11.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import Foundation

class TRISoundManager: NSObject {

    static var instance: TRISoundManager = TRISoundManager()
    let manager = OALSimpleAudio.sharedInstance()
    
    override init() {
        super.init()
    }
    
    func playSound(sound: TRISounds) {
        manager?.playEffect(sound.rawValue)
    }
    
    func preloadSounds() {
        for sound in TRISounds.allValues {
            manager?.preloadEffect(sound.rawValue)
        }
    }
}
