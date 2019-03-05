//
//  MainViewController.swift
//  WordScrambleWithoutIB
//
//  Created by 李凯 on 2019/3/5.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "words")
        
        requestLocalData()
        startGame()
        initNavigationBar()
    }
    
    func requestLocalData() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else { return }
        guard let wordString = try? String(contentsOf: url) else { return }
        allWords = wordString.components(separatedBy: "\n")
    }
    
    func startGame() {
        title = allWords.randomElement()
        //清空
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func initNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartTheGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    }
    
    @objc func restartTheGame() {
        startGame()
    }
    
    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter Your Answer", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            if let answer = alertController.textFields?[0].text {
                self.submitAnswer(answer)
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func submitAnswer(_ answer: String) {
        
        let errorTitle: String
        let errorMessage: String
        
        //替换大小写
        let lowerCaseAnswer = answer.lowercased()
        
        //1.组成单词的字母是否都从title中来
        //2.是否是全新的单词, 不是之前写过的
        //3.是否是一个真正的单词
        //4.是否跟标题单词一样
        if isPossbile(lowerCaseAnswer) {
            if isOriginal(lowerCaseAnswer) {
                if isReal(lowerCaseAnswer) {
                    if isTheSame(lowerCaseAnswer) {
                        //插入
                        usedWords.insert(lowerCaseAnswer, at: 0)
                        //显示
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                    }else{
                        errorTitle = "Same with title"
                        errorMessage = "Use Your Brain!"
                        showErrorMessage(errorTitle, errorMessage)
                    }
                }else{
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                    showErrorMessage(errorTitle, errorMessage)
                }
            }else{
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
                showErrorMessage(errorTitle, errorMessage)
            }
        }else{
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(String(describing: title))!"
            showErrorMessage(errorTitle, errorMessage)
        }
    }
    
    func isPossbile(_ word: String) -> Bool {
        //遍历word, title里包含就把该字母从title中删除
        guard var tempTitle = title else { return false }
        for item in word {
            if tempTitle.contains(item) {
                if let index = tempTitle.firstIndex(of: item) {
                    tempTitle.remove(at: index)
                }
            }else{
                return false
            }
        }
        return true
    }
    
    func isOriginal(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(_ word: String) -> Bool {
        if word.count < 3 {
            return false
        }else{
            let textChecker = UITextChecker()
            let range = textChecker.rangeOfMisspelledWord(in: word, range: NSRange(location: 0, length: word.utf16.count), startingAt: 0, wrap: false, language: "en")
            return range.location == NSNotFound
        }
    }
    
    func isTheSame(_ word: String) -> Bool {
        guard let tempTitle = title else { return false }
        if word == tempTitle {
            return false
        }else{
           return true
        }
    }
    
    func showErrorMessage(_ errorTitle: String, _ errorMessage: String){
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "words", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}
