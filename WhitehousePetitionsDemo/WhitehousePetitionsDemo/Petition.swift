//
//  Petition.swift
//  WhitehousePetitionsDemo
//
//  Created by 李凯 on 2019/3/7.
//  Copyright © 2019年 LK. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
