//
//  ShopCartViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class ShopCartViewController: BaseViewController {

    let userShopCar = UserShopCarTool.sharedUserShopCar
    
    private let shopImageView = UIImageView()
    private let emptyLabel = UILabel()
    private let emptyButton = UIButton(type: .Custom)
    
// MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavigationItem()
        
        buildEmptyUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if userShopCar.isEmpty() {
            showshopCarEmptyUI()
        }
    }

    
// MARK: - Build UI
    private func buildNavigationItem() {
        navigationItem.title = "购物车"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(UIImage(named: "v2_goback")!, target: self, action: "leftNavigitonItemClick")
    }
    
    private func buildEmptyUI() {
        shopImageView.image = UIImage(named: "v2_shop_empty")
        shopImageView.contentMode = UIViewContentMode.Center
        shopImageView.frame = CGRectMake((view.width - shopImageView.width) * 0.5, view.height * 0.25, shopImageView.width, shopImageView.height)
        shopImageView.hidden = true
        view.addSubview(shopImageView)
        
        emptyLabel.text = "亲,购物车空空的耶~赶紧挑好吃的吧"
        emptyLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        emptyLabel.textAlignment = NSTextAlignment.Center
        emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(shopImageView.frame) + 55, view.width, 50)
        emptyLabel.font = UIFont.systemFontOfSize(16)
        emptyLabel.hidden = true
        view.addSubview(emptyLabel)
        
        emptyButton.frame = CGRectMake((view.width - 150) * 0.5, CGRectGetMaxY(emptyLabel.frame) + 15, 150, 30)
        emptyButton.setBackgroundImage(UIImage(named: "btn.png"), forState: UIControlState.Normal)
        emptyButton.setTitle("去逛逛", forState: UIControlState.Normal)
        emptyButton.setTitleColor(UIColor.colorWithCustom(100, g: 100, b: 100), forState: UIControlState.Normal)
        emptyButton.addTarget(self, action: "leftNavigitonItemClick", forControlEvents: UIControlEvents.TouchUpInside)
        emptyButton.hidden = true
        view.addSubview(emptyButton)
    }
// MARK: - Private Method
    private func showshopCarEmptyUI() {
        shopImageView.hidden = false
        emptyButton.hidden = false
        emptyLabel.hidden = false
    }
    
// MARK:-  Action
    func leftNavigitonItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
