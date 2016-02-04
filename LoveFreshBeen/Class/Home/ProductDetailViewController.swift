//
//  ProductDetailViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ProductDetailViewController: BaseViewController {
    
    private let grayBackgroundColor = UIColor.colorWithCustom(248, g: 248, b: 248)
    
    private var scrollView: UIScrollView?
    private var productImageView: UIImageView?
    private var titleNameLabel: UILabel?
    private var priceView: DiscountPriceView?
    private var presentView: UIView?
    private var detailView: UIView?
    private var brandTitleLabel: UILabel?
    private var detailTitleLabel: UILabel?
    private var promptView: UIView?
    private let nameView = UIView()
    private var detailImageView: UIImageView?
    private var bottomView: UIView?
    private var yellowShopCar: YellowShopCarView?
    private var goods: Goods?
    private var buyView: BuyView?
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
    init () {
        super.init(nibName: nil, bundle: nil)
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.backgroundColor = UIColor.whiteColor()
        scrollView?.bounces = false
        view.addSubview(scrollView!)
        
        productImageView = UIImageView(frame: CGRectMake(0, 0, ScreenWidth, 400))
        productImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        scrollView!.addSubview(productImageView!)
        
        buildLineView(CGRectMake(0, CGRectGetMaxY(productImageView!.frame) - 1, ScreenWidth, 1), addView: productImageView!)
        
        let leftMargin: CGFloat = 15
        
        nameView.frame = CGRectMake(0, CGRectGetMaxY(productImageView!.frame), ScreenWidth, 80)
        nameView.backgroundColor = UIColor.whiteColor()
        scrollView!.addSubview(nameView)
        
        titleNameLabel = UILabel(frame: CGRectMake(leftMargin, 0, ScreenWidth, 60))
        titleNameLabel?.textColor = UIColor.blackColor()
        titleNameLabel?.font = UIFont.systemFontOfSize(16)
        nameView.addSubview(titleNameLabel!)
        
        buildLineView(CGRectMake(0, 80 - 1, ScreenWidth, 1), addView: nameView)
        
        presentView = UIView(frame: CGRectMake(0, CGRectGetMaxY(nameView.frame), ScreenWidth, 50))
        presentView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(presentView!)
        
        let presentButton = UIButton(frame: CGRectMake(leftMargin, 13, 55, 24))
        presentButton.setTitle("促销", forState: .Normal)
        presentButton.backgroundColor = UIColor.colorWithCustom(252, g: 85, b: 88)
        presentButton.layer.cornerRadius = 8
        presentButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        presentView?.addSubview(presentButton)
        
        let presentLabel = UILabel(frame: CGRectMake(100, 0, ScreenWidth * 0.7, 50))
        presentLabel.textColor = UIColor.blackColor()
        presentLabel.font = UIFont.systemFontOfSize(14)
        presentLabel.text = "买一赠一 (赠品有限,赠完为止)"
        presentView?.addSubview(presentLabel)
        
        buildLineView(CGRectMake(0, 49, ScreenWidth, 1), addView: presentView!)
        
        detailView = UIView(frame: CGRectMake(0, CGRectGetMaxY(presentView!.frame), ScreenWidth, 150))
        detailView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(detailView!)
        
        let brandLabel = UILabel(frame: CGRectMake(leftMargin, 0, 80, 50))
        brandLabel.textColor = UIColor.colorWithCustom(150, g: 150, b: 150)
        brandLabel.text = "品       牌"
        brandLabel.font = UIFont.systemFontOfSize(14)
        detailView?.addSubview(brandLabel)
        
        brandTitleLabel = UILabel(frame: CGRectMake(100, 0, ScreenWidth * 0.6, 50))
        brandTitleLabel?.textColor = UIColor.blackColor()
        brandTitleLabel?.font = UIFont.systemFontOfSize(14)
        detailView?.addSubview(brandTitleLabel!)
        
        buildLineView(CGRectMake(0, 50 - 1, ScreenWidth, 1), addView: detailView!)
        
        let detailLabel = UILabel(frame: CGRectMake(leftMargin, 50, 80, 50))
        detailLabel.text = "产品规格"
        detailLabel.textColor = brandLabel.textColor
        detailLabel.font = brandTitleLabel!.font
        detailView?.addSubview(detailLabel)
        
        detailTitleLabel = UILabel(frame: CGRectMake(100, 50, ScreenWidth * 0.6, 50))
        detailTitleLabel?.textColor = brandTitleLabel!.textColor
        detailTitleLabel?.font = brandTitleLabel!.font
        detailView?.addSubview(detailTitleLabel!)
        
        buildLineView(CGRectMake(0, 100 - 1, ScreenWidth, 1), addView: detailView!)
        
        let textImageLabel = UILabel(frame: CGRectMake(leftMargin, 100, 80, 50))
        textImageLabel.textColor = brandLabel.textColor
        textImageLabel.font = brandLabel.font
        textImageLabel.text = "图文详情"
        detailView?.addSubview(textImageLabel)
        
        promptView = UIView(frame: CGRectMake(0, CGRectGetMaxY(detailView!.frame), ScreenWidth, 80))
        promptView?.backgroundColor = UIColor.whiteColor()
        scrollView?.addSubview(promptView!)
        
        let promptLabel = UILabel(frame: CGRectMake(15, 5, ScreenWidth, 20))
        promptLabel.text = "温馨提示:"
        promptLabel.textColor = UIColor.blackColor()
        promptView?.addSubview(promptLabel)
        
        let promptDetailLabel = UILabel(frame: CGRectMake(15, 20, ScreenWidth - 30, 60))
        promptDetailLabel.textColor = presentButton.backgroundColor
        promptDetailLabel.numberOfLines = 2
        promptDetailLabel.text = "商品签收后, 如有问题请您在24小时内联系4008484842,并将商品及包装保留好,拍照发给客服"
        promptDetailLabel.font = UIFont.systemFontOfSize(14)
        promptView?.addSubview(promptDetailLabel)
        
        buildLineView(CGRectMake(0, ScreenHeight - 51 - NavigationH, ScreenWidth, 1), addView: view)
        
        bottomView = UIView(frame: CGRectMake(0, ScreenHeight - 50 - NavigationH, ScreenWidth, 50))
        bottomView?.backgroundColor = grayBackgroundColor
        view.addSubview(bottomView!)
        
        let addProductLabel = UILabel(frame: CGRectMake(15, 0, 70, 50))
        addProductLabel.text = "添加商品:"
        addProductLabel.textColor = UIColor.blackColor()
        addProductLabel.font = UIFont.systemFontOfSize(15)
        bottomView?.addSubview(addProductLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(goods: Goods) {
        self.init()
        self.goods = goods
        productImageView?.sd_setImageWithURL(NSURL(string: goods.img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
        titleNameLabel?.text = goods.name
        priceView = DiscountPriceView(price: goods.price, marketPrice: goods.market_price)
        priceView?.frame = CGRectMake(15, 40, ScreenWidth * 0.6, 40)
        nameView.addSubview(priceView!)
        
        if goods.pm_desc == "买一赠一" {
            presentView?.frame.size.height = 50
            presentView?.hidden = false
        } else {
            presentView?.frame.size.height = 0
            presentView?.hidden = true
            detailView?.frame.origin.y -= 50
            promptView?.frame.origin.y -= 50
        }
        
        brandTitleLabel?.text = goods.brand_name
        detailTitleLabel?.text = goods.specifics
        
        detailImageView = UIImageView(image: UIImage(named: "aaaa"))
        let scale: CGFloat = 320.0 / ScreenWidth
        detailImageView?.frame = CGRectMake(0, CGRectGetMaxY(promptView!.frame), ScreenWidth, detailImageView!.height / scale)
        scrollView?.addSubview(detailImageView!)
        scrollView?.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(detailImageView!.frame) + 50 + NavigationH)
        
        buildNavigationItem(goods.name!)
        
        buyView = BuyView(frame: CGRectMake(85, 12, 80, 25))
        buyView!.zearIsShow = true
        buyView!.goods = goods
        bottomView?.addSubview(buyView!)
        
        weak var tmpSelf = self
        yellowShopCar = YellowShopCarView(frame: CGRectMake(ScreenWidth - 70, 50 - 61 - 10, 61, 61), shopViewClick: { () -> () in
            let shopCarVC = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCarVC)
            tmpSelf!.presentViewController(nav, animated: true, completion: nil)
        })
        
        bottomView!.addSubview(yellowShopCar!)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        
        if goods != nil {
            buyView?.goods = goods
        }
        
        (navigationController as! BaseNavigationController).isAnimation = true
    }
    
    // MARK: - Build UI
    private func buildLineView(frame: CGRect, addView: UIView) {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        addView.addSubview(lineView)
    }
    
    private func buildNavigationItem(titleText: String) {
        self.navigationItem.title = titleText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("分享", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: "rightItemClick")
    }
    
    // MARK: - Action
    func rightItemClick() {
        shareActionSheet.showActionSheetViewShowInView(view) { (shareType) -> () in
            ShareManager.shareToShareType(shareType, vc: self)
        }
    }
}
