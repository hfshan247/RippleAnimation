//
//  AnimationReferences.swift
//  rippleEffectSwift
//
//  Created by APPLE on 3/4/19.
//  Copyright © 2019 anoopm. All rights reserved.
//

import Foundation
import UIKit

enum AnimationEffect {
    case Default
    case Linear
    case EaseIn
    case EaseOut
    case EaseInEaseOut
}

class RippleAnimation {
    var uiview: UIImageView?
    var color: CGColor?
    var repetetion: Int?
    var timeInterval: Double?
    var opacity: Float?
    var rings: Int?
    var grow: Float?
    var effect: AnimationEffect?
    
    private var animationId: String?
    private var timer: Timer?
    private var counter: Int? = 0
    private var animating: Bool? = false
    
    init() {
        // The Main Stuff
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Don't need to implement this
    }
    
    private func getEffect() -> CAMediaTimingFunctionName{
        switch effect {
        case .Linear?:
            return CAMediaTimingFunctionName.linear as CAMediaTimingFunctionName;
        case .EaseIn?:
            return CAMediaTimingFunctionName.easeIn as CAMediaTimingFunctionName;
        case .EaseOut?:
            return CAMediaTimingFunctionName.easeOut as CAMediaTimingFunctionName;
        case .EaseInEaseOut?:
            return CAMediaTimingFunctionName.easeInEaseOut as CAMediaTimingFunctionName;
        case .Default?:
            return CAMediaTimingFunctionName.default as CAMediaTimingFunctionName;
        default:
            return CAMediaTimingFunctionName.default as CAMediaTimingFunctionName;
        }
    }
    
    
    private func addRippleEffect() {
        /*! Creates a circular path around the view*/
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: uiview!.bounds.size.width, height: uiview!.bounds.size.height))
        /*! Position where the shape layer should be */
        let shapePosition = CGPoint(x: uiview!.bounds.size.width / 2.0, y: uiview!.bounds.size.height / 2.0)
        
        let rippleShape1 = CAShapeLayer()
        rippleShape1.bounds = CGRect(x: 0, y: 0, width: uiview!.bounds.size.width, height: uiview!.bounds.size.height)
        rippleShape1.path = path.cgPath
        rippleShape1.fillColor = color;
        rippleShape1.strokeColor = UIColor.clear.cgColor
        rippleShape1.lineWidth = 7
        rippleShape1.position = shapePosition
        rippleShape1.opacity = 0
        
        /*! Add the ripple layer as the sublayer of the reference view */
        uiview!.layer.addSublayer(rippleShape1)
        
        /*! Create scale animation of the ripples */
        
        let scaleAnim1 = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim1.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim1.toValue = NSValue(caTransform3D: CATransform3DMakeScale(CGFloat(grow!), 2, 1))
        
        /*! Create animation for opacity of the ripples */
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = opacity!
        opacityAnim.toValue = nil
        
        /*! Group the opacity and scale animations */
        
        let animation1 = CAAnimationGroup()
        animation1.animations = [scaleAnim1, opacityAnim]
        animation1.timingFunction = CAMediaTimingFunction(name: getEffect())
        var interval: Double = 1;
        interval = Double(rings!) / timeInterval!
        animation1.duration = CFTimeInterval(interval);
        animation1.repeatCount = 0;
        animation1.isRemovedOnCompletion = true
        
        let animationID = "rippleEffect" + String(describing: counter!);
        rippleShape1.add(animation1, forKey: animationID);
    }
    
    @objc func animateImage() {
        self.addRippleEffect();
        self.counter = counter! + 1;
    }
    
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: timeInterval!, target: self, selector: #selector(animateImage), userInfo:nil, repeats: true)
    }
    private func stopTimer(){
        if timer != nil {
            timer!.invalidate()
        }
    }
    
    func startAnimation(){
        if(!(animating!)){
            startTimer()
            animating = true;
        }
    }
    func stopAnimation(){
        if(animating!){
            stopTimer()
            animating = false;
        }
    }
}
