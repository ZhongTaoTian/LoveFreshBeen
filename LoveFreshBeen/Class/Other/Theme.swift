//
//  Theme.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds
public let LFBGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
public let LFBNavigationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49)
public let HotViewMargin: CGFloat = 10

public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFontOfSize(14)

// MARK: - 通知
 /// 首页headView高度改变
public let HomeTableHeadViewHeightDidChange = "HomeTableHeadViewHeightDidChange"
 /// 商品库存不足
public let GoodsInventoryProblem = "GoodsInventoryProblem"