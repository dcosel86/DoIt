//
//  taskTableViewCell.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/16/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellText: UILabel!

    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var createdDateLabel: UILabel!
    
    
    @IBOutlet weak var importantLabel: UIImageView!
    
    
    @IBOutlet weak var audioLabel: UIImageView!
    
    @IBOutlet weak var dueDateImage: UIImageView!
    
    
    
    override func prepareForReuse() {
        let layer = self.layer
        
        
       
        
        importantLabel.image = importantLabel.image!.withRenderingMode(.alwaysTemplate)
        importantLabel.tintColor = UIColor.red
       
 

        
      
        
        //layer.backgroundColor = UIColor.white.cgColor
//        layer.shadowOffset = CGSize(width: 5, height: 1)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowRadius = 1
//        layer.shadowOpacity = 0.3
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
 

   
    
}
