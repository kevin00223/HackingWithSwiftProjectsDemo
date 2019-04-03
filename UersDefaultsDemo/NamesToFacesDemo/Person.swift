//
//  Person.swift
//  NamesToFacesDemo
//
//  Created by 李凯 on 2019/3/18.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {

    func encode(with aCoder: NSCoder) {  //encode when saving/writing
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }

    required init?(coder aDecoder: NSCoder) { //decode when reading
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
