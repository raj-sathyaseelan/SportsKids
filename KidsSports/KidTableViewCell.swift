//
//  KidTableViewCell.swift
//  KidsSports
//
//  Created by Raj Sathyaseelan on 10/2/16.
//  Copyright © 2016 Token. All rights reserved.
//

import UIKit

class KidTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var kidNameLabel: UILabel!
    @IBOutlet weak var photoUIImage: UIImageView!
    @IBOutlet weak var schoolNameAgeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
