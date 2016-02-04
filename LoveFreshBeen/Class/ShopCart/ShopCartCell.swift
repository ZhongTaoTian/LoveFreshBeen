//
//  ShopCartCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ShopCartCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyView    = BuyView()
    
    var goods: Goods? {
        didSet {
            if goods?.is_xf == 1 {
                titleLabel.text = "[精选]" + goods!.name!
            } else {
                titleLabel.text = goods?.name
            }
            
            priceLabel.text = "$" + goods!.price!.cleanDecimalPointZear()
            
            buyView.goods = goods
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        titleLabel.frame = CGRectMake(15, 0, ScreenWidth * 0.5, ShopCartRowHeight)
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.blackColor()
        contentView.addSubview(titleLabel)
        
        buyView.frame = CGRectMake(ScreenWidth - 85, (ShopCartRowHeight - 25) * 0.55, 80, 25)
        contentView.addSubview(buyView)
        
        priceLabel.frame = CGRectMake(CGRectGetMinX(buyView.frame) - 100 - 5, 0, 100, ShopCartRowHeight)
        priceLabel.textAlignment = NSTextAlignment.Right
        contentView.addSubview(priceLabel)
        
        let lineView = UIView(frame: CGRectMake(10, ShopCartRowHeight - 0.5, ScreenWidth - 10, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static private let identifier = "ShopCarCell"
    
    class func shopCarCell(tableView: UITableView) -> ShopCartCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ShopCartCell
        
        if cell == nil {
            cell = ShopCartCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
}
