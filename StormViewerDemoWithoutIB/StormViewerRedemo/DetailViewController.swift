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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = selectImageName

        let imageView = UIImageView(frame: UIScreen.main.bounds)
        if let imageToLoad = selectImageName {
            imageView.image = UIImage(named: imageToLoad)
        }
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
