//
//  TRILayoutManager.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-07-18.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import Foundation

class TRILayoutManager: NSObject {

    class func setupGameLayout() {
        var layout: TRIBaseGameLayoutDevice = .iPhone6
        
        if DeviceType.IS_IPAD {
            layout = .iPad
        }
        else if DeviceType.IS_IPHONE_6P {
            layout = .iPhone6p
        }
        else if DeviceType.IS_IPHONE_5 {
            layout = .iPhone5
        }
        else if DeviceType.IS_IPHONE_4_OR_LESS {
            layout = .iPhone4OrLess
        }
        
        TRILayoutManager.setup(layout: layout)
        
    }
    
    class func setup(layout: TRIBaseGameLayoutDevice) {
        TRIGameSceneLayout.setup(layout)
        TRIOverlayLayout.setup(layout)
        TRIMenuSceneLayout.setup(layout)
    }
}
