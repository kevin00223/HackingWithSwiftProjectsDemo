//
//  ViewController.swift
//  LKStormViewer
//
//  Created by 李凯 on 2019/2/21.
//  Copyright © 2019年 LK. All rights reserved.
//

/*
 1. 拿到图片资源 并全局保存
 */

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        print("arr's count is \(pictures.count)")
    }
}

