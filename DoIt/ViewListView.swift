//
//  ViewListView.swift
//  DoIts
//
//  Created by Amanda Cosel on 3/25/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
@IBDesignable

class ViewListView: UIView {
    
    override func draw(_ rect: CGRect)
    {
let shapeLayer = CAShapeLayer()
    
    shapeLayer.shadowColor = UIColor.black.cgColor
    shapeLayer.shadowOffset = CGSize(width: 3, height: 1)
    shapeLayer.shadowRadius = 1
    shapeLayer.shadowOpacity = 0.5

        
    }
    
    
    internal func drawRingFittingInsideView(rect: CGRect)->()
    {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 3, height: 1)
        shapeLayer.shadowRadius = 1
        shapeLayer.shadowOpacity = 0.5
        
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
