//
//  CouponCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class CouponCell: UITableViewCell {

    static private let cellIdentifier = "cuoponCell"
    
    let useColor = UIColor.colorWithCustom(161, g: 120, b: 90)
    let unUseColor = UIColor.colorWithCustom(158, g: 158, b: 158)
    
    var backImageView: UIImageView? //v2_coupon_gray  v2_coupon_yellow
    var outdateImageView: UIImageView? // v2_coupon_outdated 过期 // v2_coupon_used已使用
    var titleLabel: UILabel?
    var dateLabel: UILabel?
    var descLabel: UILabel?
    var line1View: UIView?
    var line2View: UIView?
    var priceLabel: UILabel?
    var statusLabel: UILabel?
    var circleImageView: UIImageView?
    
    private let circleWidth: CGFloat = ScreenWidth * 0.16
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        contentView.backgroundColor = UIColor.clearColor()
        
        backImageView = UIImageView()
        contentView.addSubview(backImageView!)
        
        dateLabel = UILabel()
        dateLabel?.font = UIFont.systemFontOfSize(12)
        dateLabel?.textAlignment = NSTextAlignment.Center
        contentView.addSubview(dateLabel!)
    
        line1View = UIView()
        line1View?.alpha = 0.3
        contentView.addSubview(line1View!)
        
        line2View = UIView()
        line2View?.alpha = 0.3
        contentView.addSubview(line2View!)
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        titleLabel?.textAlignment = NSTextAlignment.Center
        contentView.addSubview(titleLabel!)

        circleImageView = UIImageView(frame: CGRectMake(0, 0, circleWidth, circleWidth))
        contentView.addSubview(circleImageView!)
        
        statusLabel = UILabel(frame: CGRectMake(0, 35, circleWidth, 20))
        statusLabel!.hidden = true
        statusLabel?.textColor = UIColor.colorWithCustom(105, g: 105, b: 105)
        statusLabel?.font = UIFont.systemFontOfSize(10)
        statusLabel?.textAlignment = NSTextAlignment.Center
        circleImageView?.addSubview(statusLabel!)
        
        priceLabel = UILabel()
        priceLabel?.font = UIFont.boldSystemFontOfSize(16)
        priceLabel?.frame = CGRectMake(0, 10, circleWidth, 30)
        priceLabel?.textAlignment = NSTextAlignment.Center
        priceLabel?.textColor = UIColor.whiteColor()
        circleImageView!.addSubview(priceLabel!)
        
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFontOfSize(9)
        descLabel?.numberOfLines = 0
        contentView.addSubview(descLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView: UITableView) -> CouponCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CouponCell
        if cell == nil {
            cell = CouponCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
    
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let starRightL: CGFloat = (ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 + CouponViewControllerMargin
        let rightWidth: CGFloat = (ScreenWidth - 2 * CouponViewControllerMargin) * 0.74
        
        backImageView?.frame = CGRectMake(CouponViewControllerMargin, 5, width - 2 * CouponViewControllerMargin, height - 10)
        
        let circleX = ((ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 - circleWidth) * 0.65
        circleImageView?.frame = CGRectMake(CouponViewControllerMargin + circleX, 0, circleWidth, circleWidth)
        circleImageView?.center.y = backImageView!.center.y
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake((rightWidth - titleLabel!.width) * 0.5 + starRightL, 15, titleLabel!.width, titleLabel!.height)
        
        line1View?.frame = CGRectMake(CouponViewControllerMargin + (ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 + 10, 2, (ScreenWidth - 2 * CouponViewControllerMargin) * 0.74 - 20, 0.8)
        line1View?.center.y = (titleLabel?.center.y)!
        
        dateLabel?.sizeToFit()
        dateLabel?.frame = CGRectMake((rightWidth - dateLabel!.width) * 0.5 + starRightL, CGRectGetMaxY(titleLabel!.frame) + 10, dateLabel!.width, dateLabel!.height)
        
        line2View?.frame = CGRectMake(CGRectGetMinX(dateLabel!.frame), CGRectGetMaxY(dateLabel!.frame) + 15, dateLabel!.width, 0.4)
        
        descLabel?.frame = CGRectMake(starRightL + CouponViewControllerMargin, CGRectGetMinY(line2View!.frame) + 5, rightWidth - CouponViewControllerMargin - 10, 40)
    }
    
    var coupon: Coupon? {
        didSet {
            switch coupon!.status {
            case 0:
                setCouponColor(true)
                break
            case 1:
                setCouponColor(false)
                statusLabel?.text = "已使用"
                break
            default:
                setCouponColor(false)
                statusLabel?.text = "已过期"
                break
            }
            priceLabel?.text = "$" + (coupon!.value?.cleanDecimalPointZear())!
            titleLabel?.text = " " + (coupon?.name)! + "  "
            dateLabel?.text = "有效期:  " + coupon!.start_time! + "至" + coupon!.end_time!
            descLabel?.text = coupon?.desc
        }
    }
    
    private func setCouponColor(isUse: Bool) {
        
        backImageView!.image = isUse ? UIImage(named: "v2_coupon_yellow") : UIImage(named: "v2_coupon_gray")
        titleLabel?.textColor = isUse ? useColor : unUseColor
        titleLabel?.backgroundColor = isUse ? UIColor.colorWithCustom(255, g: 244, b: 224) : UIColor.colorWithCustom(238, g: 238, b: 238)
        dateLabel?.textColor = titleLabel?.textColor
        statusLabel?.hidden = isUse
        line1View?.backgroundColor = isUse ? useColor : unUseColor
        line2View?.backgroundColor = line1View?.backgroundColor
        descLabel?.textColor = titleLabel?.textColor
    
        let tmpView = UIView(frame: CGRectMake(0, 0, circleWidth, circleWidth))
        tmpView.backgroundColor = isUse ? LFBNavigationYellowColor : UIColor.colorWithCustom(210, g: 210, b: 210)
        let image = UIImage.createImageFromView(tmpView)
        circleImageView!.image = image.imageClipOvalImage()
    }
    

    
}
