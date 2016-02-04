//
//  AdressCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class AdressCell: UITableViewCell {
    
    private let nameLabel       = UILabel()
    private let phoneLabel      = UILabel()
    private let adressLabel     = UILabel()
    private let lineView        = UIView()
    private let modifyImageView = UIImageView()
    private let bottomView      = UIView()
    
    var modifyClickCallBack:(Int -> Void)?
    
    var adress: Adress? {
        didSet {
            nameLabel.text = adress!.accept_name
            phoneLabel.text = adress!.telphone
            adressLabel.text = adress!.address
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.whiteColor()
        
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textColor = LFBTextBlackColor
        contentView.addSubview(nameLabel)
        
        phoneLabel.font = UIFont.systemFontOfSize(14)
        phoneLabel.textColor = LFBTextBlackColor
        contentView.addSubview(phoneLabel)
        
        adressLabel.font = UIFont.systemFontOfSize(13)
        adressLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(adressLabel)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        lineView.alpha = 0.2
        contentView.addSubview(lineView)
        
        modifyImageView.image = UIImage(named: "v2_address_edit_highlighted")
        modifyImageView.contentMode = UIViewContentMode.Center
        contentView.addSubview(modifyImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: "modifyImageViewClick:")
        modifyImageView.userInteractionEnabled = true
        modifyImageView.addGestureRecognizer(tap)
        
        bottomView.backgroundColor = UIColor.lightGrayColor()
        bottomView.alpha = 0.4
        contentView.addSubview(bottomView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "AdressCell"
    
    class func adressCell(tableView: UITableView, indexPath: NSIndexPath, modifyClickCallBack:(Int -> Void)) -> AdressCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? AdressCell
        if cell == nil {
            cell = AdressCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.modifyClickCallBack = modifyClickCallBack
        cell?.modifyImageView.tag = indexPath.row
        
        return cell!
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.frame = CGRectMake(10, 15, 80, 20)
        phoneLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 15, 150, 20)
        adressLabel.frame = CGRectMake(10, CGRectGetMaxY(phoneLabel.frame) + 10, width * 0.6, 20)
        lineView.frame = CGRectMake(width * 0.8, 10, 1, height - 20)
        modifyImageView.frame = CGRectMake(width * 0.8 + (width * 0.2 - 40) * 0.5, (height - 40) * 0.5, 40, 40)
        bottomView.frame = CGRectMake(0, height - 1, width, 1)
    }
    
    // MARK: - Action
    func modifyImageViewClick(tap: UIGestureRecognizer) {
        if modifyClickCallBack != nil {
            modifyClickCallBack!(tap.view!.tag)
        }
    }
    
}
