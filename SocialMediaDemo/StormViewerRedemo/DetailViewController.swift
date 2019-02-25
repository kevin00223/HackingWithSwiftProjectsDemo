//
//  DetailViewController.swift
//  StormViewerRedemo
//
//  Created by 李凯 on 2019/2/22.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectImageName: String?
    
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
        initSubviews()
        initNavigationBar()
    }
    
    func initValues() {
        view.backgroundColor = .white
        title = selectImageName
    }
    
    func initSubviews() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        if let imageToLoad = selectImageName {
            imageView.image = UIImage(named: imageToLoad)
        }
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectImageName!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //⚠️to anchor the activity view controller to the right bar button item, but this only works on iPad, ignored on iPhone.
        present(vc, animated: true, completion: nil)
    }

}
