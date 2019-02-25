//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by 李凯 on 2019/2/25.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton! //implicitly unwrapping optionals
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var questionsAnswered = 0
    var correctAnswer = 0
    var score = 0
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupButtons()
        askQuestion()
    }
    
    func askQuestion() {
        correctAnswer = Int.random(in: 0...2)
        
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()), Score is \(score)"
    }
    
    func setupButtons() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func flagButtonOnClick(_ sender: UIButton) {
        questionsAnswered += 1
//        var title: String
        if correctAnswer == sender.tag {
//            title = "Correct"
            score += 2
            askQuestion()
        }else{
//            title = "Wrong"
            score -= 2
            let alertController = UIAlertController(title: nil, message: "Wrong! That's the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.askQuestion()
            }))
            present(alertController, animated: true, completion: nil)
        }

//
//        if questionsAnswered == 10 {
//            let alertController = UIAlertController(title: nil, message: "Your final score is \(score)", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
//                self.questionsAnswered = 0
//                self.score = 0
//                self.askQuestion()
//            }))
//            present(alertController, animated: true, completion: nil)
//        }
    }

}

