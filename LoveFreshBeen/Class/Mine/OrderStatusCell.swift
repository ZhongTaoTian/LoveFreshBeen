//
//  OrderStatusCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum OrderStateType: Int {
    case Top = 0
    case Middle = 1
    case Bottom = 2
}

class OrderStatusCell: UITableViewCell {

    private var timeLabel: UILabel?
    private var titleLabel: UILabel?
    private var subTitleLable: UILabel?
    private var circleButton: UIButton?
    private var topLineView: UIView?
    private var bottomLineView: UIView?

    private var lineView: UIView?
    
    var orderStatus: OrderStatus? {
        didSet {
            timeLabel?.text = orderStatus?.status_time
            subTitleLable?.text = orderStatus?.status_desc
            titleLabel?.text = orderStatus?.status_title
            if orderStatus?.status_desc?.characters.count > 0 {
                let tmpStr = (orderStatus?.status_desc)! as NSString
                if tmpStr.length > 10 {
                    let str = tmpStr.substringToIndex(5) as NSString
                    if str.isEqualToString("下单成功，") {
                        let mutableStr = NSMutableString(string: tmpStr)
                        mutableStr.insertString("\n ", atIndex: 9)
                        subTitleLable?.text = mutableStr as String
                    }
                }
            }
        }
    }
    
    var orderStateType: OrderStateType? {
        didSet {
            switch orderStateType!.hashValue {
            case OrderStateType.Top.hashValue:
                circleButton?.selected = true
                titleLabel?.textColor = UIColor.blackColor()
                bottomLineView?.hidden = false
                topLineView?.hidden = true
                lineView?.hidden = false
                subTitleLable?.numberOfLines = 1
                break
            case OrderStateType.Middle.hashValue:
                circleButton?.selected = false
                titleLabel?.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
                bottomLineView?.hidden = false
                topLineView?.hidden = false
                lineView?.hidden = false
                subTitleLable?.numberOfLines = 1
                break
            case OrderStateType.Bottom.hashValue:
                bottomLineView?.hidden = true
                topLineView?.hidden = false
                lineView?.hidden = true
                titleLabel?.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
                circleButton?.selected = false
                subTitleLable?.numberOfLines = 0
                break
            default: break
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        let textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        
        timeLabel = UILabel()
        timeLabel?.textColor = textColor
        timeLabel?.textAlignment = NSTextAlignment.Center
        timeLabel?.font = UIFont.systemFontOfSize(12)
        contentView.addSubview(timeLabel!)
        
        circleButton = UIButton()
        circleButton?.userInteractionEnabled = false
        circleButton?.setBackgroundImage(UIImage(named: "order_grayMark"), forState: UIControlState.Normal)
        circleButton?.setBackgroundImage(UIImage(named: "order_yellowMark"), forState: UIControlState.Selected)
        contentView.addSubview(circleButton!)
        
        topLineView = UIView()
        topLineView?.backgroundColor = textColor
        topLineView?.alpha = 0.3
        contentView.addSubview(topLineView!)
        
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = textColor
        bottomLineView?.alpha = 0.3
        contentView.addSubview(bottomLineView!)
        
        titleLabel = UILabel()
        titleLabel?.textColor = textColor
        titleLabel?.font = UIFont.systemFontOfSize(15)
        contentView.addSubview(titleLabel!)
        
        subTitleLable = UILabel()
        subTitleLable?.textColor = textColor
        subTitleLable?.font = UIFont.systemFontOfSize(12)
        contentView.addSubview(subTitleLable!)
        
        lineView = UIView()
        lineView?.backgroundColor = textColor
        lineView?.alpha = 0.2
        contentView.addSubview(lineView!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static let identifier = "orderStatusCell"
    class func orderStatusCell(tableView: UITableView) -> OrderStatusCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? OrderStatusCell
        if cell == nil {
            cell = OrderStatusCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 15
        timeLabel?.frame = CGRectMake(margin, 12, 35, 20)
        circleButton?.frame = CGRectMake(CGRectGetMaxX(timeLabel!.frame) + 10, 15, 15, 15)
        topLineView?.frame = CGRectMake((circleButton?.center.x)! - 1, 0, 2, 15 )
        bottomLineView?.frame = CGRectMake((circleButton?.center.x)! - 1, 15 + 15, 2, height - 15 - 15)
        titleLabel?.frame = CGRectMake(CGRectGetMaxX(circleButton!.frame) + 20, 12, width - CGRectGetMaxX(circleButton!.frame) - 20, 20)
        subTitleLable?.frame = CGRectMake(titleLabel!.x, CGRectGetMaxY(titleLabel!.frame) + 10, width - titleLabel!.frame.origin.x, 30)
        lineView?.frame = CGRectMake(titleLabel!.x, height - 1, width - titleLabel!.x, 1)
    }
    
}
