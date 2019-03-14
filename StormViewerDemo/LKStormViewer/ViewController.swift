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

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Storm Viewer"
        
        requestData()
    }
    
    func requestData() {
        DispatchQueue.global().async { [weak self] in
            //1.获取图片资源 并全局保存
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            
            //数组排序: 闭包中$0表示第一个参数, $1表示第二个参数
            //        pictures = pictures.sorted { $0 > $1}
            self?.pictures.sort {$0 < $1}
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row] //textLabel? : optional chaining
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //1. 每个控制器都有一个storyboard属性, 但swift不确定知道该storyboard是否有值 因此需要optional chaining (try doing this, but do nothing if there is a problem)
        //2. 通过instantiateViewController()获取到对应的控制器
        //3. 由于instantiateViewController()方法返回的结果类型为UIViewController, 因此需要通过typeCasting(以optionalDowncast的形式)将返回值类型转化成DetailViewController类 并通过safely unwrapping optionals(if let)解包
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

