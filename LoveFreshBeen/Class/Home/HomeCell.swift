//
//  HomeCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum HomeCellTyep: Int {
    case Horizontal = 0
    case Vertical = 1
}

class HomeCell: UICollectionViewCell {
    //MARK: - 初始化子空间
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        return backImageView
        }()
    
    private lazy var goodsImageView: UIImageView = {
        let goodsImageView = UIImageView()
        goodsImageView.contentMode = UIViewContentMode.ScaleAspectFit
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
    
    private var discountPriceView: DiscountPriceView?
    
    private lazy var buyView: BuyView = {
        let buyView = BuyView()
        return buyView
        }()
    
    
    private var type: HomeCellTyep? {
        didSet {
            backImageView.hidden = !(type == HomeCellTyep.Horizontal)
            goodsImageView.hidden = (type == HomeCellTyep.Horizontal)
            nameLabel.hidden = (type == HomeCellTyep.Horizontal)
            fineImageView.hidden = (type == HomeCellTyep.Horizontal)
            giveImageView.hidden = (type == HomeCellTyep.Horizontal)
            specificsLabel.hidden = (type == HomeCellTyep.Horizontal)
            discountPriceView?.hidden = (type == HomeCellTyep.Horizontal)
            buyView.hidden = (type == HomeCellTyep.Horizontal)
        }
    }
    
    var addButtonClick:((imageView: UIImageView) -> ())?
    
    // MARK: - 便利构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        addSubview(backImageView)
        addSubview(goodsImageView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        weak var tmpSelf = self
        buyView.clickAddShopCar = {()
            if tmpSelf?.addButtonClick != nil {         
                tmpSelf!.addButtonClick!(imageView:tmpSelf!.goodsImageView)
            }
        }
    }
    
    // MARK: - 模型set方法
    var activities: Activities? {
        didSet {
            self.type = .Horizontal
            backImageView.sd_setImageWithURL(NSURL(string: activities!.img!), placeholderImage: UIImage(named: "v2_placeholder_full_size"))
        }
    }
    
    var goods: Goods? {
        didSet {
            self.type = .Vertical
            goodsImageView.sd_setImageWithURL(NSURL(string: goods!.img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
            nameLabel.text = goods?.name
            if goods!.pm_desc == "买一赠一" {
                giveImageView.hidden = false
            } else {
                
                giveImageView.hidden = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
        goodsImageView.frame = CGRectMake(0, 0, width, width)
        nameLabel.frame = CGRectMake(5, width, width - 15, 20)
        fineImageView.frame = CGRectMake(5, CGRectGetMaxY(nameLabel.frame), 30, 15)
        giveImageView.frame = CGRectMake(CGRectGetMaxX(fineImageView.frame) + 3, fineImageView.y, 35, 15)
        specificsLabel.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(fineImageView.frame), width, 20)
        discountPriceView?.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(specificsLabel.frame), 60, height - CGRectGetMaxY(specificsLabel.frame))
        buyView.frame = CGRectMake(width - 85, height - 30, 80, 25)
    }
    
}
