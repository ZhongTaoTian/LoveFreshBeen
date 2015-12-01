//
//  SupermarketHeadView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/27.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class SupermarketHeadView: UITableViewHeaderFooterView {

    var titleLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clearColor()
        
        contentView.backgroundColor = UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 0.8)
        buildTitleLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRectMake(HotViewMargin, 0, width - HotViewMargin, height)
    }
    
    private func buildTitleLabel() {
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        titleLabel.textAlignment = NSTextAlignment.Left
        contentView.addSubview(titleLabel)
    }

}

