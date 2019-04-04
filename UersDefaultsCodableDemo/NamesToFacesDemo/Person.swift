//
//  Person.swift
//  NamesToFacesDemo
//
//  Created by 李凯 on 2019/3/18.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
