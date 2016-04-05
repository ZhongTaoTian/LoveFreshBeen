//
//  SearchProductViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class SearchProductViewController: AnimationViewController {
    
    private let contentScrollView = UIScrollView(frame: ScreenBounds)
    private let searchBar = UISearchBar()
    private var hotSearchView: SearchView?
    private var historySearchView: SearchView?
    private let cleanHistoryButton: UIButton = UIButton()
    private var searchCollectionView: LFBCollectionView?
    private var goodses: [Goods]?
    private var collectionHeadView: NotSearchProductsView?
    private var yellowShopCar: YellowShopCarView?
    
    // MARK: - Lief Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildContentScrollView()
        
        buildSearchBar()
        
        buildCleanHistorySearchButton()
        
        loadHotSearchButtonData()
        
        loadHistorySearchButtonData()
        
        buildsearchCollectionView()
        
        buildYellowShopCar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        
        if searchCollectionView != nil && goodses?.count > 0 {
            searchCollectionView!.reloadData()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
    }
    
    // MARK: - Build UI
    private func buildContentScrollView() {
        contentScrollView.backgroundColor = view.backgroundColor
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.delegate = self
        view.addSubview(contentScrollView)
    }
    
    private func buildSearchBar() {
        
        (navigationController as! BaseNavigationController).backBtn.frame = CGRectMake(0, 0, 10, 40)
        
        let tmpView = UIView(frame: CGRectMake(0, 0, ScreenWidth * 0.8, 30))
        tmpView.backgroundColor = UIColor.whiteColor()
        tmpView.layer.masksToBounds = true
        tmpView.layer.cornerRadius = 6
        tmpView.layer.borderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1).CGColor
        tmpView.layer.borderWidth = 0.2
        let image = UIImage.createImageFromView(tmpView)
        
        searchBar.frame = CGRectMake(0, 0, ScreenWidth * 0.9, 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.setSearchFieldBackgroundImage(image, forState: .Normal)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        let navVC = navigationController as! BaseNavigationController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn!.addTarget(self, action: "leftButtonClcik", forControlEvents: UIControlEvents.TouchUpInside)
        navVC.isAnimation = false
    }
    
    private func buildYellowShopCar() {
        
        weak var tmpSelf = self
        
        yellowShopCar = YellowShopCarView(frame: CGRectMake(ScreenWidth - 70, ScreenHeight - 70 - NavigationH, 61, 61), shopViewClick: { () -> () in
            let shopCarVC = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCarVC)
            tmpSelf!.presentViewController(nav, animated: true, completion: nil)
        })
        yellowShopCar?.hidden = true
        view.addSubview(yellowShopCar!)
    }
    
    private func loadHotSearchButtonData() {
        var array: [String]?
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        if historySearch == nil {
            historySearch = [String]()
            NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        }
        weak var tmpSelf = self
        let pathStr = NSBundle.mainBundle().pathForResource("SearchProduct", ofType: nil)
        let data = NSData(contentsOfFile: pathStr!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            array = (dict.objectForKey("data")! as! NSDictionary).objectForKey("hotquery") as? [String]
            if array?.count > 0 {
                hotSearchView = SearchView(frame: CGRectMake(10, 20, ScreenWidth - 20, 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array!) { (sender) -> () in
                    let str = sender.titleForState(UIControlState.Normal)
                    tmpSelf!.writeHistorySearchToUserDefault(str!)
                    tmpSelf!.searchBar.text = sender.titleForState(UIControlState.Normal)
                    tmpSelf!.loadProductsWithKeyword(sender.titleForState(UIControlState.Normal)!)
                }
                hotSearchView!.frame.size.height = hotSearchView!.searchHeight
                
                contentScrollView.addSubview(hotSearchView!)
            }
        }
    }
    
    private func loadHistorySearchButtonData() {
        if historySearchView != nil {
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        
        weak var tmpSelf = self;
        let array = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        if array?.count > 0 {
            historySearchView = SearchView(frame: CGRectMake(10, CGRectGetMaxY(hotSearchView!.frame) + 20, ScreenWidth - 20, 0), searchTitleText: "历史记录", searchButtonTitleTexts: array!, searchButtonClickCallback: { (sender) -> () in
                tmpSelf!.searchBar.text = sender.titleForState(UIControlState.Normal)
                tmpSelf!.loadProductsWithKeyword(sender.titleForState(UIControlState.Normal)!)
            })
            historySearchView!.frame.size.height = historySearchView!.searchHeight
            
            contentScrollView.addSubview(historySearchView!)
            updateCleanHistoryButton(false)
        }
    }
    
    private func buildCleanHistorySearchButton() {
        cleanHistoryButton.setTitle("清 空 历 史", forState: UIControlState.Normal)
        cleanHistoryButton.setTitleColor(UIColor.colorWithCustom(163, g: 163, b: 163), forState: UIControlState.Normal)
        cleanHistoryButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        cleanHistoryButton.backgroundColor = view.backgroundColor
        cleanHistoryButton.layer.cornerRadius = 5
        cleanHistoryButton.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
        cleanHistoryButton.layer.borderWidth = 0.5
        cleanHistoryButton.hidden = true
        cleanHistoryButton.addTarget(self, action: "cleanSearchHistorySearch", forControlEvents: UIControlEvents.TouchUpInside)
        contentScrollView.addSubview(cleanHistoryButton)
    }
    
    private func updateCleanHistoryButton(hidden: Bool) {
        if historySearchView != nil {
            cleanHistoryButton.frame = CGRectMake(0.1 * ScreenWidth, CGRectGetMaxY(historySearchView!.frame) + 20, ScreenWidth * 0.8, 40)
        }
        cleanHistoryButton.hidden = hidden
    }
    
    private func buildsearchCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin)
        
        searchCollectionView = LFBCollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64), collectionViewLayout: layout)
        searchCollectionView!.delegate = self
        searchCollectionView!.dataSource = self
        searchCollectionView!.backgroundColor = LFBGlobalBackgroundColor
        searchCollectionView!.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        searchCollectionView?.hidden = true
        collectionHeadView = NotSearchProductsView(frame: CGRectMake(0, -80, ScreenWidth, 80))
        searchCollectionView?.addSubview(collectionHeadView!)
        searchCollectionView?.contentInset = UIEdgeInsetsMake(80, 0, 30, 0)
        searchCollectionView?.registerClass(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        view.addSubview(searchCollectionView!)
    }
    
    // MARK: - Private Method
    private func writeHistorySearchToUserDefault(str: String) {
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        for text in historySearch! {
            if text == str {
                return
            }
        }
        historySearch!.append(str)
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
    }
    
    // MARK: - Action
    func cleanSearchHistorySearch() {
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        historySearch?.removeAll()
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
        updateCleanHistoryButton(true)
    }
    
    func leftButtonClcik() {
        searchBar.endEditing(false)
    }
    
    // MARK: - Private Method
    func loadProductsWithKeyword(keyWord: String?) {
        if keyWord == nil || keyWord?.characters.count == 0 {
            return
        }
        
        ProgressHUDManager.setBackgroundColor(UIColor.whiteColor())
        ProgressHUDManager .showWithStatus("正在全力加载")
        
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SearchProducts.loadSearchData { (data, error) -> Void in
                if data?.data?.count > 0 {
                    tmpSelf?.goodses = data!.data!
                    tmpSelf?.searchCollectionView?.hidden = false
                    tmpSelf?.yellowShopCar?.hidden = false
                    tmpSelf?.searchCollectionView?.reloadData()
                    tmpSelf?.collectionHeadView?.setSearchProductLabelText(keyWord!)
                    tmpSelf?.searchCollectionView?.setContentOffset(CGPointMake(0, -80), animated: false)
                    ProgressHUDManager.dismiss()
                }
            }
        }
    }
}


extension SearchProductViewController: UISearchBarDelegate, UIScrollViewDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count > 0 {
            
            writeHistorySearchToUserDefault(searchBar.text!)
            
            loadProductsWithKeyword(searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        searchBar.endEditing(false)
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            searchCollectionView?.hidden = true
            yellowShopCar?.hidden = true
        }
    }
}


extension SearchProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goodses?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCell
        cell.goods = goodses![indexPath.row]
        weak var tmpSelf = self
        cell.addButtonClick = ({ (imageView) -> () in
            tmpSelf?.addProductsToBigShopCarAnimation(imageView)
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemSize = CGSizeMake((ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, 250)
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if goodses?.count <= 0 || goodses == nil {
            return CGSizeZero
        }
        
        return CGSizeMake(ScreenWidth, 30)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HomeCollectionFooterView

            footerView.setFooterTitle("无更多商品", textColor: UIColor.colorWithCustom(50, g: 50, b: 50))

            return footerView

        } else {
            return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = ProductDetailViewController(goods: goodses![indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}





