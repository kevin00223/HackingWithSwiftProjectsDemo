//
//  ViewController.swift
//  WhitehousePetitionsDemoWithoutIB
//
//  Created by 李凯 on 2019/3/7.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    /// 最终要展示的数据源
    var dataSourcePetitions = [Petition]()
    
    /// 全部数据源
    var petitions = [Petition]()
    
    /// 与用户输入相匹配的数据源
    var matchedPetitions = [Petition]()
    
    var urlString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initValue()
        initNavigationBar()
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
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonItemOnTap))
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
            dataSourcePetitions = petitions
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Loading Erro", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func rightBarButtonItemOnTap() {
//        let alertController = UIAlertController(title: "Note", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alertController, animated: true, completion: nil)
        
        dataSourcePetitions = petitions
        tableView.reloadData()
        matchedPetitions.removeAll()
        
        let alertController = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (alertAction) in
            if let submitString = alertController.textFields?[0].text {
                for item in self.petitions {
                    if item.title.contains(submitString) {
                        self.matchedPetitions.append(item)
                    }
                }
                if !self.matchedPetitions.isEmpty {
                    self.dataSourcePetitions = self.matchedPetitions
                    self.tableView.reloadData()
                }else{
                    let alertController = UIAlertController(title: "No petition matched, please try again", message: nil, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourcePetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataSourcePetitions[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailItem = dataSourcePetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

