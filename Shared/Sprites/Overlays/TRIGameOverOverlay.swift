//
//  TRIGameOverOverlay.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-20.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import SpriteKit

class TRIGameOverOverlay: TRIBaseOverlay {

    private weak var lblTitle: SKLabelNode!
    private weak var lblSubTitle: SKLabelNode!
    
    override init(withSize size: CGSize) {
        super.init(withSize: size)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let lblTitle = SKLabelNode(fontNamed: Fonts.HelveticaNeueLight.rawValue)
        lblTitle.position = CGPoint(
            x: self.center.x,
            y: self.center.y + TRIOverlayLayout.titleYOffset
        )
        lblTitle.fontSize = TRIOverlayLayout.titleFontSize
        self.addChild(lblTitle)
        self.lblTitle = lblTitle
        
        let lblSubTitle = SKLabelNode(fontNamed: Fonts.HelveticaNeueLight.rawValue)
        lblSubTitle.position = CGPoint(
            x: self.center.x,
            y: self.center.y - 40 + TRIOverlayLayout.subTitleYOffset
        )
        lblSubTitle.fontSize = TRIOverlayLayout.subTitleFontSize
        self.addChild(lblSubTitle)
        self.lblSubTitle = lblSubTitle
    }
    
    func show(withTitle title: String, subTitle: String, closure: (() -> Void)?) {
        lblTitle.text = title
        lblSubTitle.text = subTitle
        
        self.animateElementUp(lblTitle, endPosition: center, completion: nil)
        self.fadeIn(lblSubTitle, delay: 0.8) { () -> Void in
            if let closure = closure {
                closure()
            }
        }
        
        self.fadeInBackground()
        
        self.isHidden = false
    }
}
