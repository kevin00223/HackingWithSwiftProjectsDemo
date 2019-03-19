//
//  PersonCell.swift
//  NameToFacesDemoWithoutIB
//
//  Created by 李凯 on 2019/3/19.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit
import SnapKit

class PersonCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "xxx"
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.left.top.equalTo(contentView).offset(8)
            make.right.equalTo(contentView).offset(-8)
            make.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.left.right.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
}
