//
//  ViewController.swift
//  SwiftyWords
//
//  Created by 李凯 on 2019/3/13.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
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
        initSubviews()
    }
    
    func initSubviews() {
        //scoreLabel
        scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.right.equalTo(-10)
            make.left.equalTo(10)
        }
        
        //cluesLabel
        cluesLabel = UILabel()
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0;
        view.addSubview(cluesLabel)
        cluesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(140)
            make.left.equalTo(40)
        }
        
        //answersLabel
        answersLabel = UILabel()
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        answersLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.top.equalTo(cluesLabel)
        }
        
        //currentAnswer
        currentAnswer = UITextField()
        currentAnswer.placeholder = "Tap Letters To Guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        currentAnswer.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(answersLabel.snp.bottom).offset(80)
        }
        
        //submit
        let submit = UIButton(type: .system)
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        submit.snp.makeConstraints { (make) in
            make.top.equalTo(currentAnswer.snp.bottom).offset(40)
            make.centerX.equalTo(view).offset(-50)
        }
        
        //clear
        let clear = UIButton(type: .system)
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        clear.snp.makeConstraints { (make) in
            make.top.equalTo(submit)
            make.centerX.equalTo(view).offset(50)
        }
        
        //containerview to hold buttons
        let containerView = UIView()
        let containerViewWidth = 750
        let containerViewHeight = 600
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(containerViewWidth)
            make.height.equalTo(containerViewHeight)
            make.top.equalTo(clear.snp.bottom).offset(120)
        }
        
        let col = 5
        let row = 4
        let width = containerViewWidth / col
        let height = containerViewHeight / row
        
        for r in 0..<row {
            for c in 0..<col {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.frame = CGRect(x: c * width, y: r * height, width: width, height: height)
                containerView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
    }


}

