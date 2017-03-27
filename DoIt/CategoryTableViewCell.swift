//
//  CategoryTableViewCell.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/26/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    @IBOutlet weak var disclosureArrow: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
