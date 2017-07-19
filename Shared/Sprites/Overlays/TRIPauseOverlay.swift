//
//  TRIPauseOverlay.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-07-18.
//  Copyright © 2017 ModernGames. All rights reserved.
//

import SpriteKit

class TRIPauseOverlay: TRIBaseOverlay {

    weak var btnResume: TRIWireButton?
    weak var btnMenu: TRIWireButton?
    private weak var lblTitle: SKLabelNode?
    
    override init(withSize size: CGSize){
        super.init(withSize: size)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        setupLabel()
        setupResumeButton()
        setupQuitButton()
    }
    
    private func setupLabel() {
        let lblTitle = SKLabelNode(
            fontNamed: Fonts.HelveticaNeueLight.rawValue
        )
        lblTitle.position = CGPoint(
            x: self.sizeReference.width / 2,
            y: self.sizeReference.height / 2
        )
        lblTitle.fontSize = TRIOverlayLayout.titleFontSize
        lblTitle.text = "Paused"
        self.addChild(lblTitle)
        self.lblTitle = lblTitle
    }
    
    private func setupResumeButton() {
        let btnResume = TRIWireButton(
            color: SKColor.white,
            size: TRIOverlayLayout.btnResumeSize,
            title: "Resume"
        )
        self.addChild(btnResume)
        btnResume.zPosition = 9999999
        var yOffset = self.sizeReference.height / 2
        yOffset -= TRIOverlayLayout.btnResumeOffset
        btnResume.position = CGPoint(
            x: self.sizeReference.width / 2,
            y: yOffset
        )
        btnResume.isUserInteractionEnabled = true
        btnResume.label.fontSize = TRIOverlayLayout.buttonFontSize
        self.btnResume = btnResume
    }
    
    private func setupQuitButton() {
        let btnMenu = TRIWireButton(
            color: SKColor.white,
            size: TRIOverlayLayout.btnResumeSize,
            title: "Quit"
        )
        self.addChild(btnMenu)
        btnMenu.zPosition = 9999999
        var yOffset = self.btnResume!.position.y
        yOffset -= self.btnResume!.size.height / 2
        yOffset -= btnMenu.size.height / 2
        yOffset -= TRIOverlayLayout.btnResumeOffset
        
        btnMenu.position = CGPoint(
            x: self.sizeReference.width / 2,
            y: yOffset
        )
        btnMenu.isUserInteractionEnabled = true
        btnMenu.label.fontSize = TRIOverlayLayout.buttonFontSize
        self.btnMenu = btnMenu
    }
    
    func showPauseScreen(closure: (() -> Void)?){
        self.lblTitle?.removeAllActions()
        self.btnMenu?.removeAllActions()
        self.btnResume?.removeAllActions()
        
        let position = CGPoint(
            x: self.sizeReference.width / 2,
            y: self.sizeReference.height / 2 + 50
        )
        
        self.btnResume?.alpha = 0
        self.btnMenu?.alpha = 0
        
        self.fadeInBackground()
        self.animateElementUp(self.lblTitle!, endPosition: position, completion: {() -> Void in
            
            self.fadeIn(
                self.btnResume!,
                delay: 0,
                completion: nil
            )
            
            self.fadeIn(
                self.btnMenu!,
                delay: 0.2,
                completion: nil
            )
            
            if let closure = closure {
                closure()
            }
        })
        
        self.isHidden = false
    }
}
