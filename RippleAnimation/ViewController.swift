//
//  SecondViewController.swift
//  rippleEffectSwift
//
//  Created by APPLE on 3/1/19.
//  Copyright © 2019 anoopm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animation1 = RippleAnimation();
    
    @IBOutlet private weak var imageView_1:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func buttonStartAnimationClicked(_ sender: Any) {
        //animation1 = AnimRef();
        animation1.uiview = self.imageView_1;
        //animation1.timer = self.animationTimer;
        //animation1.counter = 0;
        animation1.timeInterval = 1;
        animation1.repetetion = 3;
        animation1.color = UIColor.black.cgColor;
        animation1.opacity = 0.3;
        animation1.grow = 3.5;
        animation1.rings = 3;
        animation1.effect = AnimationEffect.EaseInEaseOut;
        //self.startAnimation(animRef: animation1)
        animation1.startAnimation()
}
    
    @IBAction func buttonStopAnimationClicked(_ sender: Any) {
        self.animation1.stopAnimation()
    }
    
}
