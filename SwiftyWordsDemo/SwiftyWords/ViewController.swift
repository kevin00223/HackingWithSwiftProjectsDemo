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
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score = 0 {
        didSet { //⚠️property observer
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initSubviews()
        loadLevel()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        DispatchQueue.global().async { [weak self] in
            if let levelFileURL = Bundle.main.url(forResource: "level\(String(describing: self?.level))", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    DispatchQueue.main.async { [weak self] in
                        for(index, line) in lines.enumerated() {
                            let parts = line.components(separatedBy: ":")
                            let answer = parts[0]
                            let clue = parts[1]
                            
                            clueString += "\(index + 1).\(clue)\n"
                            
                            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                            solutionString += "\(solutionWord.count) letters\n"
                            self?.solutions.append(solutionWord)
                            
                            let bits = answer.components(separatedBy: "|")
                            letterBits += bits
                        }
                    }
                }
            }
        }
        
        // ⚠️trims spaces, tabs and line breaks
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits.shuffle()
        
        if letterBits.count == letterButtons.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
    }
    
    func levelUp() {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        score = 0
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    func wrongGuess() {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    @objc func submitButtonTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if activatedButtons.count == 20 {
                activatedButtons.removeAll()
                
                let alertController = UIAlertController(title: "Well Done", message: "Are you ready for the next level?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Let's go", style: .default, handler: { (action) in
                    self.levelUp()
                }))
                present(alertController, animated: true, completion: nil)
            }
        } else {
            score -= 1
            
            let alertContoller = UIAlertController(title: "Oops", message: "You get it wrong, please try again!", preferredStyle: .alert)
            alertContoller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.wrongGuess()
            }))
            present(alertContoller, animated: true, completion: nil)
        }
    }
    
    @objc func clearButtonTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    @objc func letterButtonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
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
        submit.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(submit)
        submit.snp.makeConstraints { (make) in
            make.top.equalTo(currentAnswer.snp.bottom).offset(40)
            make.centerX.equalTo(view).offset(-50)
        }
        
        //clear
        let clear = UIButton(type: .system)
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(clear)
        clear.snp.makeConstraints { (make) in
            make.top.equalTo(submit)
            make.centerX.equalTo(view).offset(50)
        }
        
        //containerview to hold buttons
        let containerView = UIView()
        let containerViewWidth = 750
        let containerViewHeight = 400
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
                letterButton.layer.borderColor = UIColor.black.cgColor
                letterButton.layer.borderWidth = 1
                letterButton.layer.cornerRadius = 3.0
                letterButton.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
                containerView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
    }


}

