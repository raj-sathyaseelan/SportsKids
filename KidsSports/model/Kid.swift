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
    var sports = [Sport]()
    
    init(firstName: String, lastName: String, photo:UIImage, schoolName: String, age: Int, sports: [Sport]) {
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.schoolName = schoolName
        self.age = age
        self.sports = sports
    }

    
}


class Sport {
    var sportName: String
    var sportIcon: String
    
    init(sportName: String, sportIcon: String) {
        self.sportName = sportName
        self.sportIcon = sportIcon
    }
    
}
