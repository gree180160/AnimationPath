//
//  ViewController.swift
//  AnimationPath
//
//  Created by WillowRivers on 16/8/22.
//  Copyright © 2016年 WillowRivers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fishLayer : CALayer! ;
    var fishIndex : Int = 0 ;
    var time : NSTimer! ;
    var startButton : UIButton! ;
    override func viewDidLoad() {
        super.viewDidLoad() ;
        let bgLayer = CALayer(layer: view.layer) ;
        bgLayer.contents = UIImage(named: "bg.jpg")?.CGImage ;
        //bgLayer.contentsGravity = kCAGravityCenter ;
        //bgLayer.masksToBounds = true ;
        bgLayer.borderColor = UIColor.blackColor().CGColor ;
        bgLayer.borderWidth = 5 ;
        bgLayer.frame = self.view.layer.frame ;
        view.layer.addSublayer(bgLayer) ;
        time = NSTimer.scheduledTimerWithTimeInterval(0.3 , target: self, selector: "change", userInfo: nil, repeats: true) ;
        
        fishLayer = CALayer(layer: view.layer) ;
        //fishLayer.contentsGravity = kCAGravityCenter ;
        //fishLayer.masksToBounds = true ;
        fishLayer.frame = CGRectMake(100, 60, 90, 40) ;
        view.layer.addSublayer(fishLayer) ;
        
        startButton = UIButton(type: .System) ;
        startButton.frame = CGRectMake(15, 15, 150, 24) ;
        startButton.backgroundColor = UIColor.brownColor() ;
        startButton.setTitle("开始播放", forState: .Normal) ;
        startButton.layer.cornerRadius = 10 ;
        startButton.addTarget(self, action: "move", forControlEvents: .TouchUpInside) ;
        
        view.addSubview(startButton) ;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func change()
    {
        fishLayer.contents = UIImage(named: "fish" + String((fishIndex++)%10)  + ".png")?.CGImage ;
    }
    
    func move()
    {
        let positionAnim = CAKeyframeAnimation(keyPath: "position") ;
        let movePath = CGPathCreateMutable() ;
        CGPathAddArc(movePath, nil, 170, 175, 150, CGFloat(-M_PI / 2), CGFloat(-M_PI * 5/2) , true) ;
        positionAnim.path = movePath ;
        
        let transformAnim = CAKeyframeAnimation(keyPath: "transform") ;
        transformAnim.values = [NSValue(CATransform3D: CATransform3DIdentity),NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI) , 0, 0, 1)),NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(2 * M_PI) , 0, 0, 1))]
        
        let animGroup = CAAnimationGroup() ;
        animGroup.animations = [positionAnim , transformAnim] ;
        animGroup.repeatCount = 50 ;
        animGroup.duration = 25 ;
        fishLayer.addAnimation(animGroup, forKey: "move") ;
        
    }

}

