//
//  ViewController.swift
//  WordScramble
//
//  Created by 李凯 on 2019/3/4.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* 通过文件管理器(FileManager)获取全部资源文件!!
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let arr = try! fm.contentsOfDirectory(atPath: path)
        */
        
        // 通过文件名+文件后缀 获取资源路径!!
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt") { // optional unwrapping
            // loading a file into a string !!
            if let startWords = try? String(contentsOf: url) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty { //速度比通过.count==0判断要快
            allWords = ["silkWorm"]
        }
        
        // 开始游戏
        startGame()
        
        //初始化导航栏
        initNavigationBar()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    }
    
    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        
        // trailing closure
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let answer = alertController.textFields?[0].text else { return }
            self.submit(answer)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        let errorTitle: String
        let errorMessage: String

        if isPossible(lowerAnswer) {
            if isOriginal(lowerAnswer) {
                if isReal(lowerAnswer) {
                    //验证通过后 添加到usedWords中
                    usedWords.insert(lowerAnswer, at: 0) //注意与append的区别: insert at可以将元素加在任一index处, 而append只能将元素添加到数组最后

                    //1. 因为每次最多只插入一行 因此使用reloadData()速度反而更慢
                    //2. 使用reloadData()无动画效果 看上去很突兀
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else{
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            }else{
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        }else{
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }

        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // 组成单词的字母是否都从title中来
    func isPossible(_ word: String) -> Bool {
        // 🌰 "cease" from "agencies", using each letter only once
        // algorithm: to loop through every letter in the player's answer, seeing whether it exists in the eight-letter start word we are playing with. If it does exist, we remove the letter from the start word, then continue the loop
        guard var tempTitle = title?.lowercased() else { return false }
        
        for letter in word {
            //找到该letter第一次出现的index
            if let position = tempTitle.firstIndex(of: letter) {
                tempTitle.remove(at: position)
            }else{
                //没找到就直接返回false
                return false
            }
        }
        return true
    }
    
    // 是否是全新的单词, 不是之前写过的
    func isOriginal(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    // 是否是一个真正的单词
    func isReal(_ word: String) -> Bool {
        // 用来检测是否有拼写错误的类
        let wordChecker = UITextChecker()
        let wordRange = NSRange(location: 0, length: word.utf16.count)
        let typoRange = wordChecker.rangeOfMisspelledWord(in: word, range: wordRange, startingAt: 0, wrap: false, language: "en")
        
        return typoRange.location == NSNotFound //NSNotFound是Int类型, location属性返回的也是Int类型
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

