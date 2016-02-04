//
//  NewCharacteristicsCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class GuideCell: UICollectionViewCell {
    
    private let newImageView = UIImageView(frame: ScreenBounds)
    private let nextButton = UIButton(frame: CGRectMake((ScreenWidth - 100) * 0.5, ScreenHeight - 110, 100, 33))
    
    var newImage: UIImage? {
        didSet {
            newImageView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(newImageView)
        
        nextButton.setBackgroundImage(UIImage(named: "icon_next"), forState: UIControlState.Normal)
        nextButton.addTarget(self, action: "nextButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.hidden = true
        contentView.addSubview(nextButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextButtonHidden(hidden: Bool) {
        nextButton.hidden = hidden
    }
    
    func nextButtonClick() {
        NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
    }
}
