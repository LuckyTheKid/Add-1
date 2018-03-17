//
//  GameScene.swift
//  addSound
//
//  Created by Heidi Gentry-Kolen on 3/16/16.
//  Copyright (c) 2016 Heidi Gentry-Kolen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameBackgroundMusic:  SKAudioNode!
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameBackgroundMusic = SKAudioNode(fileNamed:"background2.wav")
        addChild(gameBackgroundMusic)
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        gameBackgroundMusic.runAction(SKAction.stop())
        
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
