//
//  Kid.swift
//  KidsSports
//
//  Created by Raj Sathyaseelan on 10/1/16.
//  Copyright © 2016 Token. All rights reserved.
//

import UIKit

class Kid {
    
    var firstName: String
    var lastName: String
    var photo: UIImage
    var schoolName: String
    var age: Int
    
    init(firstName: String, lastName: String, photo:UIImage, schoolName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.schoolName = schoolName
        self.age = age
    }

    
}
