//
//  MyShopViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 16/1/8.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//

import UIKit

class MyShopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的店铺"
        
        let imageView = UIImageView(image: UIImage(named: "v2_store_empty"))
        imageView.center = CGPointMake(view.center.x, view.center.y - 150);
        view.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, view.width, 30))
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "还没有收藏的店铺呦~"
        view.addSubview(titleLabel)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
