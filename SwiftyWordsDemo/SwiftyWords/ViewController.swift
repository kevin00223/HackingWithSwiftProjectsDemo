//
//  ViewController.swift
//  SwiftyWords
//
//  Created by 李凯 on 2019/3/13.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

