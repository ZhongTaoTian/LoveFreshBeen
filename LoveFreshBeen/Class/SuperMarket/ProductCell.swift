//
//  ProductCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ProductCell: UITableViewCell {
    
    static private let identifier = "ProductCell"
    
    //MARK: - 初始化子控件
    private lazy var goodsImageView: UIImageView = {
        let goodsImageView = UIImageView()
        return goodsImageView
        }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = NSTextAlignment.Left
        nameLabel.font = HomeCollectionTextFont
        nameLabel.textColor = UIColor.blackColor()
        return nameLabel
        }()
    
    private lazy var fineImageView: UIImageView = {
        let fineImageView = UIImageView()
        fineImageView.image = UIImage(named: "jingxuan.png")
        return fineImageView
        }()
    
    private lazy var giveImageView: UIImageView = {
        let giveImageView = UIImageView()
        giveImageView.image = UIImage(named: "buyOne.png")
        return giveImageView
        }()
    
    private lazy var specificsLabel: UILabel = {
        let specificsLabel = UILabel()
        specificsLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        specificsLabel.font = UIFont.systemFontOfSize(12)
        specificsLabel.textAlignment = .Left
        return specificsLabel
        }()
    
    private lazy var buyView: BuyView = {
        let buyView = BuyView()
        return buyView
        }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        lineView.alpha = 0.05
        return lineView
        }()
    
    private var discountPriceView: DiscountPriceView?

    var addProductClick:((imageView: UIImageView) -> ())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        contentView.backgroundColor = UIColor.whiteColor()
        
        addSubview(goodsImageView)
        addSubview(lineView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        weak var tmpSelf = self
        buyView.clickAddShopCar = {
            if tmpSelf!.addProductClick != nil {
                tmpSelf!.addProductClick!(imageView: tmpSelf!.goodsImageView)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView: UITableView) -> ProductCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ProductCell
        
        if cell == nil {
            cell = ProductCell(style: .Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }

    // MARK: - 模型set方法
    var goods: Goods? {
        didSet {
            goodsImageView.sd_setImageWithURL(NSURL(string: goods!.img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
            nameLabel.text = goods?.name
            if goods!.pm_desc == "买一赠一" {
                giveImageView.hidden = false
            } else {
                giveImageView.hidden = true
            }
            
            if goods!.is_xf == 1 {
                fineImageView.hidden = false
            } else {
                fineImageView.hidden = true
            }
            
            if discountPriceView != nil {
                discountPriceView!.removeFromSuperview()
            }
            discountPriceView = DiscountPriceView(price: goods?.price, marketPrice: goods?.market_price)
            addSubview(discountPriceView!)
            
            specificsLabel.text = goods?.specifics
            buyView.goods = goods
        }
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        goodsImageView.frame = CGRectMake(0, 0, height, height)
        fineImageView.frame = CGRectMake(CGRectGetMaxX(goodsImageView.frame), HotViewMargin, 30, 16)

        if fineImageView.hidden {
            nameLabel.frame = CGRectMake(CGRectGetMaxX(goodsImageView.frame) + 3, HotViewMargin - 2, width - CGRectGetMaxX(goodsImageView.frame), 20)
        } else {
            nameLabel.frame = CGRectMake(CGRectGetMaxX(fineImageView.frame) + 3, HotViewMargin - 2, width - CGRectGetMaxX(fineImageView.frame), 20)
        }
        
        giveImageView.frame = CGRectMake(CGRectGetMaxX(goodsImageView.frame), CGRectGetMaxY(nameLabel.frame), 35, 15)
        
        specificsLabel.frame = CGRectMake(CGRectGetMaxX(goodsImageView.frame), CGRectGetMaxY(giveImageView.frame), width, 20)
        discountPriceView?.frame = CGRectMake(CGRectGetMaxX(goodsImageView.frame), CGRectGetMaxY(specificsLabel.frame), 60, height - CGRectGetMaxY(specificsLabel.frame))
        lineView.frame = CGRectMake(HotViewMargin, height - 1, width - HotViewMargin, 1)
        buyView.frame = CGRectMake(width - 85, height - 30, 80, 25)
    }
}

