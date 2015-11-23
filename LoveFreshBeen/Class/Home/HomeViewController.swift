//
//  HomeViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var headView: HomeTableHeadView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavigationItem()
        
        buildTableHeadView()
        
    }
    
// MARK:- Creat UI
    func buildNavigationItem() {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton("扫一扫", titleColor: UIColor.blackColor(),
                                                                    image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
                                                                    target: self, action: "leftItemClick", type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("搜 索", titleColor: UIColor.blackColor(),
                                                                    image: UIImage(named: "icon_search")!,hightLightImage: nil,
                                                            target: self, action: "rightItemClick", type: ItemButtonType.Right)
    }
    
    func buildTableHeadView() {
        headView = HomeTableHeadView(frame: CGRectMake(0, 0, ScreenWidth, 150))
        headView?.delegate = self
        view.addSubview(headView!)
    }
    
    
    
    
    
// MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
    // MARK: TableHeadViewAction
}

// MARK:- HomeHeadViewDelegate
extension HomeViewController: HomeTableHeadViewDelegate {
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        print(index)
    }
}

