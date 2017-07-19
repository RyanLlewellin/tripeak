//
//  TRIOverlayLayout.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-20.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import Foundation

class TRIOverlayLayout: TRIBaseGameLayout {

    static var btnResumeSize: CGSize = CGSize(
        width: 230,
        height: 70
    )
    static var btnMenuSize: CGSize = CGSize(
        width: 180,
        height: 55
    )
    static var buttonFontSize: CGFloat = 20.0
    static var btnResumeOffset: CGFloat = 25.0
    static var titleYOffset: CGFloat = 0.0
    static var subTitleYOffset: CGFloat = 0.0
    static var titleFontSize: CGFloat = 50.0
    static var subTitleFontSize: CGFloat = 25.0
    
    override class func setupIphone5() {
        titleFontSize = 45.0
        btnResumeOffset = 10.0
    }
    
    override class func setupIphone4OrLess() {
        titleFontSize = 40.0
        btnResumeOffset = 10.0
        btnMenuSize = CGSize(width: 120, height: 40)
        btnResumeSize = CGSize(width: 180, height: 50)
    }
}
