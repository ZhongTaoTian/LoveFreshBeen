//
//  UIImage + Extension.swift
//  LoveFreshBeen
//
//  Created by MacBook on 15/11/29.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        CGContextSetAlpha(ref, alpha)
        CGContextSetFillColorWithColor(ref, color.CGColor)
        CGContextFillRect(ref, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
