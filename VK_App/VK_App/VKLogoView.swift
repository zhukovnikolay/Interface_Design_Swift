//
//  VKLogoView.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 01.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class VKLogoView: UIView {

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.clear.cgColor)
//        context.setFillColor(UIColor.white.cgColor)
        
        let path = UIBezierPath()
        path.lineWidth = 2
        path.move(to: CGPoint(x: 90, y: 90))
        path.addArc(withCenter: CGPoint(x: 90, y: 0), radius: 90, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: 30, y: 0))
//        path.addLine(to: CGPoint(x: 60, y: 60))
        path.addQuadCurve(to: CGPoint(x: 60, y: 60), controlPoint: CGPoint(x: 30, y: 45))
        path.addLine(to: CGPoint(x: 60, y: 0))
        path.addLine(to: CGPoint(x: 90, y: 0))
        path.addLine(to: CGPoint(x: 90, y: 30))
        path.addLine(to: CGPoint(x: 120, y: 0))
        path.addLine(to: CGPoint(x: 150, y: 0))
        path.addQuadCurve(to: CGPoint(x: 110, y: 45), controlPoint: CGPoint(x: 150, y: 15))
//        path.addLine(to: CGPoint(x: 110, y: 45))
//        path.addLine(to: CGPoint(x: 150, y: 90))
        path.addQuadCurve(to: CGPoint(x: 150, y: 90), controlPoint: CGPoint(x: 150, y: 75))
        path.addLine(to: CGPoint(x: 120, y: 90))
        path.addLine(to: CGPoint(x: 90, y: 60))
        path.close()
        path.stroke()
//        path.fill()
        
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 2
        self.layer.addSublayer(layer)
//
//
//        let followLayer = CAShapeLayer()
//
//        followLayer.backgroundColor = UIColor.green.cgColor
//        followLayer.position = CGPoint(x: 40, y: 20)
//        followLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//
//
//        let followAnimation = CAKeyframeAnimation()
//        followAnimation.path = path.cgPath
//        followAnimation.calculationMode = .cubic
//        followAnimation.duration = 3
//        followLayer.add(followAnimation, forKey: "position")

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = 0.5
        strokeStartAnimation.duration = 3

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1.2
        strokeEndAnimation.duration = 3

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3.5
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        layer.add(animationGroup, forKey: "line")


//        startLayer.addSublayer(followLayer)





//        self.layer.addSublayer(startLayer)
    }

}
