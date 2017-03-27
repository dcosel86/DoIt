//
//  CompletedTasksButtonView.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/24/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
@IBDesignable

class CompletedTasksButtonView: UIView {
    
   
    
    @IBInspectable var mainColor: UIColor = UIColor.blue
        {
        didSet { print("mainColor was set here") }
    }
    @IBInspectable var ringColor: UIColor = UIColor.orange
        {
        didSet { print("bColor was set here") }
    }
    @IBInspectable var ringThickness: CGFloat = 4
        {
        didSet { print("ringThickness was set here") }
    }
    
    @IBInspectable var rinkOpacity: CGFloat = 4
    
    @IBInspectable var isSelected: Bool = true
    
    override func draw(_ rect: CGRect)
    {
        let dotPath = UIBezierPath(ovalIn:rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = dotPath.cgPath
        shapeLayer.fillColor = mainColor.cgColor
        layer.addSublayer(shapeLayer)
//        layer.opacity = 0.3
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 3, height: 1)
        shapeLayer.shadowRadius = 1
        shapeLayer.shadowOpacity = 0.5
        
        
        if (isSelected) { drawRingFittingInsideView(rect: rect) }
    }
    
    internal func drawRingFittingInsideView(rect: CGRect)->()
    {
        let hw:CGFloat = ringThickness/2
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: hw,dy: hw) )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = ringColor.cgColor
        shapeLayer.lineWidth = ringThickness
        layer.addSublayer(shapeLayer)
        
        //shapeLayer.opacity = 0.5
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
