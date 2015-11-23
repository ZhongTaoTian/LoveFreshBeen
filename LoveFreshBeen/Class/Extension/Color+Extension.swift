//
//  Color+Extension.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/19.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

extension UIColor {

    class func colorWithCustom(r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
    }

}