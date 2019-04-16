//
//  WhackSlot.swift
//  WhackAPenguin
//
//  Created by 李凯 on 2019/4/16.
//  Copyright © 2019年 LK. All rights reserved.
//

import SpriteKit
import UIKit

//MARK: encapsulate all hole related functionality
class WhackSlot: SKNode {
    
    // store the penguin picture node
    var charNode: SKSpriteNode!
    
    // slot是否可见
    var isVisible = false
    // slot是否可点击
    var isHit = false
    
    // 不重写init方法 (直接调用父类的)
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        //用来遮住下方创建的penguin图片, 营造企鹅进洞的效果
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
    }
}
