//
//  ViewController.swift
//  NamesToFacesDemo
//
//  Created by 李凯 on 2019/3/18.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var people = [Person]()
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initValues()
        initNavigationBar()
        
        print(UUID().uuidString)
    }
    
    func initValues() {
        collectionView.backgroundColor = .black
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    @objc func addNewPerson() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            initImagePickerController()
        } else {
            initImagePickerController()
        }
    }
    
    func initImagePickerController() {
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { //optional typecasting
            fatalError("Unable to dequeue PersonCell")
        }
        
        let person = people[indexPath.item]
        cell.nameLabel.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // alertController 1
//        let person = people[indexPath.item]
//        let alertController = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: nil)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            guard let newName = alertController.textFields?[0].text else { return }
//            person.name = newName
//            self.collectionView.reloadData()
//        }))
//        present(alertController, animated: true, completion: nil)
        
        // alertController 2
        let alertController = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
        let person = people[indexPath.item]
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (action) in
            guard let newName = alertController.textFields?[0].text else { return }
            person.name = newName
            self.collectionView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            self.people.remove(at: indexPath.item)
            self.collectionView.reloadData()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //该回调方法中 参数info是个字典, 因此可以通过对应key取值
        //1. 通过editedImage这个key 拿到iamge对象
        guard let image = info[.editedImage] as? UIImage else { return }
        
        //2. 在Documents目录下 创建唯一的文件路径
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        //3. 将image对应的二进制数据 写入第2步创建的文件路径下
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return URL(fileURLWithPath: paths[0])
    }
    
}

