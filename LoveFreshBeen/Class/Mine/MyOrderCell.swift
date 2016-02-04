//
//  MyOrderCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class MyOrderCell: UITableViewCell {
    
    private var timeLabel: UILabel?
    private var statusTextLabel: UILabel?
    private var lineView1: UIView?
    private var goodsImageViews: OrderImageViews?
    private var lineView2: UIView?
    private var productNumsLabel: UILabel?
    private var productsPriceLabel: UILabel?
    private var payLabel: UILabel?
    private var lineView3: UIView?
    private var buttons: OrderButtons?
    private var indexPath: NSIndexPath?
    
    weak var delegate: MyOrderCellDelegate?
    
    var order: Order? {
        didSet {
            timeLabel?.text = order?.create_time
            statusTextLabel?.text = order?.textStatus
            goodsImageViews?.order_goods = order?.order_goods
            productNumsLabel?.text = "共" + "\(order!.buy_num)" + "件商品"
            productsPriceLabel?.text = "$" + (order!.user_pay_amount)!
            buttons?.buttons = order?.buttons
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.whiteColor()
        
        timeLabel = UILabel()
        timeLabel?.font = UIFont.systemFontOfSize(13)
        timeLabel?.textColor = UIColor.blackColor()
        contentView.addSubview(timeLabel!)
    
        statusTextLabel = UILabel()
        statusTextLabel?.textAlignment = NSTextAlignment.Right
        statusTextLabel?.font = timeLabel?.font
        statusTextLabel?.textColor = UIColor.redColor()
        contentView.addSubview(statusTextLabel!)
        
        goodsImageViews = OrderImageViews()
        contentView.addSubview(goodsImageViews!)
        
        productNumsLabel = UILabel()
        productNumsLabel?.textColor = UIColor.grayColor()
        productNumsLabel?.textAlignment = NSTextAlignment.Right
        productNumsLabel?.font = timeLabel?.font
        contentView.addSubview(productNumsLabel!)
        
        payLabel = UILabel()
        payLabel?.text = "实付:"
        payLabel?.textColor = UIColor.grayColor()
        payLabel?.font = productNumsLabel?.font
        contentView.addSubview(payLabel!)
        
        productsPriceLabel = UILabel()
        productsPriceLabel?.textColor = UIColor.blackColor()
        productsPriceLabel?.textAlignment = NSTextAlignment.Right
        productsPriceLabel?.font = payLabel?.font
        productsPriceLabel?.textColor = UIColor.grayColor()
        contentView.addSubview(productsPriceLabel!)
        
        weak var tmpSelf = self
        buttons = OrderButtons(frame: CGRectZero, buttonClickCallBack: { (type) -> () in
            if tmpSelf?.delegate != nil {
                if tmpSelf!.delegate!.respondsToSelector("orderCellButtonDidClick:buttonType:") {
                    tmpSelf!.delegate!.orderCellButtonDidClick!(tmpSelf!.indexPath!, buttonType: type)
                }
            }
        })
        buttons?.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(buttons!)
        
        lineView1 = UIView()
        lineView1?.backgroundColor = UIColor.lightGrayColor()
        lineView1?.alpha = 0.1
        contentView.addSubview(lineView1!)
        
        lineView2 = UIView()
        lineView2?.backgroundColor = UIColor.lightGrayColor()
        lineView2?.alpha = 0.1
        contentView.addSubview(lineView2!)
        
        lineView3 = UIView()
        lineView3?.backgroundColor = UIColor.lightGrayColor()
        lineView3?.alpha = 0.1
        contentView.addSubview(lineView3!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "OrderCell"
    class func myOrderCell(tableView: UITableView, indexPath: NSIndexPath) -> MyOrderCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MyOrderCell
        
        if cell == nil {
            cell = MyOrderCell(style: .Default, reuseIdentifier: identifier)
        }
        
        cell?.indexPath = indexPath
        
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 10
        let topViewHeight: CGFloat = 30
        contentView.frame = CGRectMake(0, 0, width, height - 20)
        timeLabel?.frame = CGRectMake(margin, 0, ScreenWidth, topViewHeight)
        statusTextLabel?.frame = CGRectMake(ScreenWidth - 150, 0, 140, topViewHeight)
        lineView1?.frame = CGRectMake(margin, topViewHeight, ScreenWidth - margin, 1)
        goodsImageViews?.frame = CGRectMake(0, topViewHeight, width, 65)
        lineView2?.frame = CGRectMake(margin, CGRectGetMaxY(goodsImageViews!.frame), width - margin, 1)
        productsPriceLabel?.frame = CGRectMake(width - margin - 60, CGRectGetMaxY(goodsImageViews!.frame), 60, topViewHeight)
        payLabel?.frame = CGRectMake(width - 70 - 20, productsPriceLabel!.y, 40, topViewHeight)
        productNumsLabel?.frame = CGRectMake(width - 220, productsPriceLabel!.y, 100, topViewHeight)
        lineView3?.frame = CGRectMake(margin, CGRectGetMaxY(payLabel!.frame), width - margin, 1)
        buttons?.frame = CGRectMake(0, CGRectGetMaxY(productNumsLabel!.frame), width, 40)
    }
}

@objc protocol MyOrderCellDelegate: NSObjectProtocol {
    optional func orderCellButtonDidClick(indexPath: NSIndexPath, buttonType: Int)
}

class OrderImageViews: UIView {
    
    var imageViews: UIView?
    var arrowImageView: UIImageView?
    var order_goods: [[OrderGoods]]? {
        didSet {
            let imageViewsSubViews = imageViews?.subviews
            for i in 0..<order_goods!.count {
                if i < 4 {
                    let subImageView = imageViewsSubViews![i] as! UIImageView
                    subImageView.hidden = false
                    subImageView.sd_setImageWithURL(NSURL(string: order_goods![i][0].img!), placeholderImage: UIImage(named: "author"))
                }
            }
            
            for var i = order_goods!.count; i < 4; i++ {
                let subImageView = imageViewsSubViews![i]
                subImageView.hidden = true
            }
            
            if order_goods?.count >= 5 {
                let subImageView = imageViewsSubViews![4]
                subImageView.hidden = false
            } else {
                let subImageView = imageViewsSubViews![4]
                subImageView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViews = UIView(frame: CGRectMake(0, 5, ScreenWidth, 55))
        for i in 0...4 {
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i) * 60 + 10, 0, 55, 55))
            if 4 == i {
                imageView.image = UIImage(named: "v2_goodmore")
            }
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.hidden = true
            imageViews?.addSubview(imageView)
        }
        
        arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView?.frame = CGRectMake(ScreenWidth - 15, (65 - arrowImageView!.bounds.size.height) * 0.5, arrowImageView!.bounds.size.width, arrowImageView!.bounds.size.height)
        imageViews?.addSubview(arrowImageView!)
        addSubview(imageViews!)
    }
    
    convenience init(frame: CGRect ,order_goods: [[OrderGoods]]) {
        self.init(frame: frame)
        self.order_goods = order_goods
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OrderButtons: UIView {
    
    var buttonClickCallBack: ((type: Int) -> ())?
    
    var buttons: [OrderButton]? {
        didSet {
            for var i = subviews.count; i > 0; i-- {
                let subBtnView = self.subviews[i-1]
                subBtnView.removeFromSuperview()
            }
            
            let btnW: CGFloat = 60
            let btnH: CGFloat = 26
            
            for i in 0..<buttons!.count {
                let btn = UIButton(frame: CGRectMake(ScreenWidth - CGFloat(i + 1) * (btnW + 10) - 5, (self.height - btnH) * 0.5, btnW, btnH))
                btn.tag = i
                btn.titleLabel?.font = UIFont.systemFontOfSize(12)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 5
                btn.backgroundColor = LFBNavigationYellowColor
                btn.setTitle(buttons![i].text, forState: UIControlState.Normal)
                btn.addTarget(self, action: "orderButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
                addSubview(btn)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, buttonClickCallBack:(type: Int) -> ()) {
        self.init(frame: frame)
        self.buttonClickCallBack = buttonClickCallBack
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0..<subviews.count {
            let subBtnView = subviews[i]
            subBtnView.frame.origin.y = (self.height - 26) * 0.5
        }
    }
    
    func orderButtonClick(sender: UIButton) {
        if buttonClickCallBack != nil {
            buttonClickCallBack!(type: buttons![sender.tag].type)
        }
    }
}






