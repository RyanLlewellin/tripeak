//
//  TRIHighscoreElement.swift
//  Tripeak
//
//  Created by Ryan Llewellin on 2017-04-20.
//  Copyright © 2017 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIHighscoreElement: SKNode, TRIHighscoreManagerDelegate {

    weak var textField: SKLabelNode?
    
    override init() {
        super.init()
        
        let textField = SKLabelNode(fontNamed: TRIGameSceneLayout.hudFont)
        textField.fontSize = TRIGameSceneLayout.hudFontSize
        textField.verticalAlignmentMode = .center
        
        self.addChild(textField)
        self.textField = textField
        self.updateTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateTextField() {
        self.textField?.text = "Score: \(TRIHighScoreManager.instance.formattedScore)"
    }
    
    func scoreUpdated(score: Int) {
        self.updateTextField()
    }

}
