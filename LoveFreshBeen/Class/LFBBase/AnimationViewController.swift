//
//  AnimationViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/1.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController {
    
    var animationLayers: [CALayer]?
    
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(imageView: UIImageView) {
        if animationLayers == nil {
            animationLayers = [CALayer]()
        }
        
        let frame = imageView.convertRect(imageView.bounds, toView: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        transitionLayer.fillMode = kCAFillModeRemoved
        
        let p1 = transitionLayer.position
        let p3X = view.width - view.width / 5 - 10
        let p3 = CGPointMake(p3X, ScreenHeight - 20)
                
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, p1.x, p1.y)
        CGPathAddLineToPoint(path, nil, p3.x, p3.y)
        positionAnimation.removedOnCompletion = true
        positionAnimation.path = path
        positionAnimation.fillMode = kCAFillModeForwards
        
        let transformAnimation =  CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(CATransform3D: CATransform3DScale(CATransform3DIdentity, 0.1, 0.1, 1))
        transformAnimation.fillMode = kCAFillModeForwards
        transformAnimation.removedOnCompletion = true
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0.1
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.removedOnCompletion = true
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.5
        groupAnimation.delegate = self
        
        transitionLayer.addAnimation(groupAnimation, forKey: "cartParabola")
        
        view.layer.addSublayer(transitionLayer)
        animationLayers!.append(transitionLayer)
        
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.4 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            transitionLayer.hidden = true
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if animationLayers!.count > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.hidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayers?.removeFirst()
            view.layer.removeAnimationForKey("cartParabola")
        }
    }
}
