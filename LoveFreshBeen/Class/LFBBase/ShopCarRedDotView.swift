//
//  ShopCarRedDotView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ShopCarRedDotView: UIView {
    
    private static let instance = ShopCarRedDotView()
    
    class var sharedRedDotView: ShopCarRedDotView {
        return instance
    }
    
    private var numberLabel: UILabel?
    private var redImageView: UIImageView?
    
    var buyNumber: Int = 0 {
        didSet {
            if 0 == buyNumber {
                numberLabel?.text = ""
                hidden = true
            } else {
                if buyNumber > 99 {
                    numberLabel?.font = UIFont.systemFontOfSize(8)
                } else {
                    numberLabel?.font = UIFont.systemFontOfSize(10)
                }
                
                hidden = false
                numberLabel?.text = "\(buyNumber)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, 20, 20))
        backgroundColor = UIColor.clearColor()
        
        redImageView = UIImageView(image: UIImage(named: "reddot"))
        addSubview(redImageView!)
        
        numberLabel = UILabel()
        numberLabel!.font = UIFont.systemFontOfSize(10)
        numberLabel!.textColor = UIColor.whiteColor()
        numberLabel?.textAlignment = NSTextAlignment.Center
        addSubview(numberLabel!)
        
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        redImageView?.frame = bounds
        numberLabel?.frame = CGRectMake(0, 0, width, height)
    }
    
    func addProductToRedDotView(animation: Bool) {
        buyNumber++
        
        if animation {
            reddotAnimation()
        }
    }
    
    func reduceProductToRedDotView(animation: Bool) {
        if buyNumber > 0 {
            buyNumber--
        }
        
        if animation {
            reddotAnimation()
        }
    }
    
    private func reddotAnimation() {
        UIView.animateWithDuration(ShopCarRedDotAnimationDuration, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: { (completion) -> Void in
                UIView.animateWithDuration(ShopCarRedDotAnimationDuration, animations: { () -> Void in
                    self.transform = CGAffineTransformIdentity
                    }, completion: nil)
        })
    }
}
