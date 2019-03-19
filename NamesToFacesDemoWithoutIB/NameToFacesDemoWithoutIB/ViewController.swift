//
//  ViewController.swift
//  NameToFacesDemoWithoutIB
//
//  Created by 李凯 on 2019/3/19.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var people = [Person]()
    
    lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 180)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .cyan
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PersonCell.classForCoder(), forCellWithReuseIdentifier: "cellID")
        return collectionView
    }()
    
    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    @objc func rightBarButtonItemClicked() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return URL(fileURLWithPath: paths[0])
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue personcell")
        }
        cell.backgroundColor = .yellow
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.masksToBounds = true
        
        let person = people[indexPath.item]
        cell.nameLabel.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let person = people[indexPath.item]
        
        let alertController = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            guard let input = alertController.textFields?[0].text else { return }
            person.name = input
            self.collectionView.reloadData()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
