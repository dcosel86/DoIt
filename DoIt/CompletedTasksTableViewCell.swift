//
//  CompletedTasksTableViewCell.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/17/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class CompletedTasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completedTaskNameLabel: UILabel!
    
    @IBOutlet weak var completedTaskTextLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
