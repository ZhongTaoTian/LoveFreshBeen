//
//  HomeViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var flag: Int = -1
    var headView: HomeTableHeadView?
    var collectionView: UICollectionView!
    var lastContentOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeNotification()
        
        buildNavigationItem()
        
        buildCollectionView()
        
        buildTableHeadView()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK:- addNotifiation
    func addHomeNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "homeTableHeadViewHeightDidChange:", name: HomeTableHeadViewHeightDidChange, object: nil)
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
        headView = HomeTableHeadView()
        
        headView?.delegate = self
        weak var tmpSelf = self
        HeadResources.loadHomeHeadData { (data, error) -> Void in
            if error == nil {
                tmpSelf?.headView?.headData = data
            }
        }
        
        collectionView.addSubview(headView!)
    }
    
    func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin)
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigationH), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
    // MARK: Notifiation Action
    func homeTableHeadViewHeightDidChange(noti: NSNotification) {
        collectionView!.contentInset = UIEdgeInsetsMake(noti.object as! CGFloat, 0, NavigationH, 0)
        collectionView!.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)
        lastContentOffsetY = collectionView.contentOffset.y
    }
}

// MARK:- HomeHeadViewDelegate TableHeadViewAction
extension HomeViewController: HomeTableHeadViewDelegate {
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        print(index)
    }
    
    func tableHeadView(headView: HomeTableHeadView, iconClick index: Int) {
        print(index)
    }
}

// MARK:- UICollectionViewDelegate UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
            return 20
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemSize = CGSizeZero
        if indexPath.section == 0 {
            itemSize = CGSizeMake(ScreenWidth - HomeCollectionViewCellMargin * 2, 140)
        } else if indexPath.section == 1 {
            itemSize = CGSizeMake((ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, 250)
        }
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin * 2)
        }
        
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin * 8)
        }
        
        return CGSizeZero
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if lastContentOffsetY <= collectionView.contentOffset.y {

            //Animation
            
            lastContentOffsetY = collectionView.contentOffset.y
        }
    }
}

