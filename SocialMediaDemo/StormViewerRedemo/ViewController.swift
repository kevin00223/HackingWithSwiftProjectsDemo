//
//  ViewController.swift
//  StormViewerRedemo
//
//  Created by 李凯 on 2019/2/22.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var images = [String]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initValues()
        initSubviews()
        requestDataSource()
        initNavigationBar()
    }
    
    //初始化初始值
    func initValues() {
        title = "Storm Viewer"
    }
    
    //初始化子控件
    func initSubviews() {
        self.view.addSubview(tableView)
    }
    
    //获取数据资源
    func requestDataSource() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let arr = try! fm.contentsOfDirectory(atPath: path)
        for item in arr {
            if item.hasPrefix("nssl") {
                images.append(item)
            }
        }
        
        images.sort {$0 < $1}
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonItemOnClick))
    }
    
    @objc func rightBarButtonItemOnClick() {
        let alertController = UIAlertController(title: "Share", message: "Share This App to Your Friends", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = images[indexPath.row] //optional chaining: try doing this, but do nothing if there is a problem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.selectImageName = images[indexPath.row]
        navigationController?.pushViewController(vc, animated:true)
        
    }
}

