//
//  MineCell.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class MineCell: UITableViewCell {
    
    var mineModel: MineCellModel? {
        didSet {
            titleLabel.text = mineModel!.title
            iconImageView.image = UIImage(named: mineModel!.iconName!)
        }
    }
    
    static private let identifier = "CellID"
    
    class func cellFor(tableView: UITableView) -> MineCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MineCell
        
        if cell == nil {
            cell = MineCell(style: .Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    let bottomLine = UIView()
    private lazy var iconImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var arrowView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImageView)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.alpha = 0.8
        contentView.addSubview(titleLabel)
        
        bottomLine.backgroundColor = UIColor.grayColor()
        bottomLine.alpha = 0.15
        contentView.addSubview(bottomLine)
        
        arrowView.image = UIImage(named: "icon_go")
        contentView.addSubview(arrowView)
        
        selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowView.frame = CGRectMake(width - 20, (height - (arrowView.image?.size.height)!) * 0.5, (arrowView.image?.size.width)!, (arrowView.image?.size.height)!)
        
        let rightMargin: CGFloat = 10
        let iconWH: CGFloat = 20
        iconImageView.frame = CGRectMake(rightMargin, (height - iconWH) * 0.5, iconWH, iconWH)
        titleLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame) + rightMargin, 0, 200, height)
        
        let leftMarge: CGFloat = 20
        bottomLine.frame = CGRectMake(leftMarge, height - 0.5, width - leftMarge, 0.5)
    }
    
}


class MineCellModel: NSObject {
    
    var title: String?
    var iconName: String?
    
    class func loadMineCellModels() -> [MineCellModel] {
        
        var mines = [MineCellModel]()
        let path = NSBundle.mainBundle().pathForResource("MinePlist", ofType: "plist")
        let arr = NSArray(contentsOfFile: path!)

        for dic in arr! {
            mines.append(MineCellModel.mineModel(dic as! NSDictionary))
        }
        
        return mines
    }
    
    class func mineModel(dic: NSDictionary) -> MineCellModel {
    
        let model = MineCellModel()
        model.title = dic["title"] as? String
        model.iconName = dic["iconName"] as? String
        
        return model
    }
    
}






