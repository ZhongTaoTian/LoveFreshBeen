//
//  LFBRefreshHeader.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class LFBRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        stateLabel?.hidden = false
        lastUpdatedTimeLabel?.hidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: MJRefreshState.Idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Refreshing)
        
        setTitle("下拉刷新", forState: .Idle)
        setTitle("松手开始刷新", forState: .Pulling)
        setTitle("正在刷新", forState: .Refreshing)
    }
}
