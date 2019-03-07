//
//  ViewController.swift
//  WhitehousePetitionsDemoWithoutIB
//
//  Created by 李凯 on 2019/3/7.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var urlString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initValue()
        requestData()
    }
    
    func initValue() {
        view.backgroundColor = .white
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
    }
    
    func requestData() {
        guard let url = URL(string: urlString) else { return }
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
           petitions = jsonPetitions.results
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Loading Erro", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

