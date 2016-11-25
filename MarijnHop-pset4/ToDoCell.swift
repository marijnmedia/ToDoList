//
//  ToDoCell.swift
//  MarijnHop-pset4
//
//  Created by Marijn Hop on 22/11/2016.
//  Copyright © 2016 Marijn Hop. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
