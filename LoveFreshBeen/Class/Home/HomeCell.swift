//
//  HomeCell.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/23.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var backImageView: UIImageView?
    var goodsImageView: UIImageView?
    var name: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("cccc")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
