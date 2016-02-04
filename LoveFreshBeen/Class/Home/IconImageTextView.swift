//
//  IconImageTextView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class IconImageTextView: UIView {

    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?

    var activitie: Activities? {
        didSet {
           textLabel?.text = activitie?.name
            imageView?.sd_setImageWithURL(NSURL(string: activitie!.img!)!, placeholderImage: placeholderImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.userInteractionEnabled = false
        imageView?.contentMode = UIViewContentMode.Center
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = NSTextAlignment.Center
        textLabel!.font = UIFont.systemFontOfSize(12)
        textLabel!.textColor = UIColor.blackColor()
        textLabel?.userInteractionEnabled = false
        addSubview(textLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(5, 5, width - 15, height - 30)
        textLabel?.frame = CGRectMake(5, height - 25, imageView!.width, 20)
    }
}
