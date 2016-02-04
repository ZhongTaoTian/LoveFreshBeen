//
//  NotSearchProductsView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class NotSearchProductsView: UIView {
    
    private let topBackView = UIView()
    private let searchLabel = UILabel()
    private let markImageView = UIImageView()
    private let productLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        topBackView.frame = CGRectMake(0, 0, width, 50)
        topBackView.backgroundColor = UIColor.colorWithCustom(249, g: 242, b: 216)
        addSubview(topBackView)
        
        markImageView.contentMode = UIViewContentMode.ScaleAspectFill
        markImageView.image = UIImage(named: "icon_exclamationmark")
        markImageView.frame = CGRectMake(15, (50 - 27) * 0.5, 27, 27)
        addSubview(markImageView)
        
        productLabel.textColor = UIColor.colorWithCustom(148, g: 107, b: 81)
        productLabel.font = UIFont.systemFontOfSize(14)
        productLabel.frame = CGRectMake(CGRectGetMaxX(markImageView.frame) + 10, 10, width * 0.7, 15)
        productLabel.text = "暂时没搜到〝星巴克〞相关商品"
        addSubview(productLabel)
        
        searchLabel.textColor = UIColor.colorWithCustom(252, g: 185, b: 47)
        searchLabel.font = UIFont.systemFontOfSize(12)
        searchLabel.text = "换其他关键词试试看,但是并没有什么卵用~"
        searchLabel.frame = CGRectMake(productLabel.x, CGRectGetMaxY(productLabel.frame) + 5, width * 0.7, 15)
        addSubview(searchLabel)
        
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.text = "大家都在买"
        titleLabel.frame = CGRectMake(10, 60, 200, 15)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSearchProductLabelText(text: String) {
        productLabel.text = "暂时没搜到" + "〝" + text + "〞" + "相关商品"
    }
}
