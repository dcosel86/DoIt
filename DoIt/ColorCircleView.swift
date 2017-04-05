//
//  ColorCircleView.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/4/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
@IBDesignable

class ColorCircleView: UIView {
    
    @IBInspectable var mainColor: UIColor? = UIColor.white
        {
        didSet { print("mainColor was set here") }
    }
    @IBInspectable var ringColor: UIColor = UIColor.black
        {
        didSet { print("bColor was set here") }
    }
    @IBInspectable var ringThickness: CGFloat = 1
        {
        didSet { print("ringThickness was set here") }
    }
    
    @IBInspectable var rinkOpacity: CGFloat = 0
    
    @IBInspectable var isSelected: Bool = true
    
    override func draw(_ rect: CGRect)
    {
        let dotPath = UIBezierPath(ovalIn:rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = dotPath.cgPath
        shapeLayer.fillColor = mainColor?.cgColor
        layer.addSublayer(shapeLayer)
                layer.opacity = 1
        
//                shapeLayer.shadowColor = UIColor.black.cgColor
//                shapeLayer.shadowOffset = CGSize(width: 3, height: 1)
//                shapeLayer.shadowRadius = 1
//                shapeLayer.shadowOpacity = 0.5
        
        
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
        
//        shapeLayer.opacity = 0.5
    }

   

}
