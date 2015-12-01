//
//  ShopCartViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class ShopCartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        bulidNavigationItem()
    }
    
    private func bulidNavigationItem() {
        navigationItem.title = "购物车"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(UIImage(named: "v2_goback")!, target: self, action: "leftNavigitonItemClick")
    }
    
// MARK:-  Action
    func leftNavigitonItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
