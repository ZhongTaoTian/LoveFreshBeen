//
//  MyAdressViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class MyAdressViewController: BaseViewController {
    
    private var addAdressButton: UIButton?
    private var nullImageView = UIView()
    
    var selectedAdressCallback:((adress: Adress) -> ())?
    var isSelectVC = false
    var adressTableView: LFBTableView?
    var adresses: [Adress]? {
        didSet {
            if adresses?.count == 0 {
                nullImageView.hidden = false
                adressTableView?.hidden = true
            } else {
                nullImageView.hidden = true
                adressTableView?.hidden = false
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(selectedAdress: ((adress:Adress) -> ())) {
        self.init(nibName: nil, bundle: nil)
        selectedAdressCallback = selectedAdress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()

        buildAdressTableView()

        buildNullImageView()

        loadAdressData()

        buildBottomAddAdressButtom()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    private func buildNavigationItem() {
        navigationItem.title = "我的收获地址"
    }
    
    private func buildAdressTableView() {
        adressTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        adressTableView?.frame.origin.y += 10;
        adressTableView?.backgroundColor = UIColor.clearColor()
        adressTableView?.rowHeight = 80
        adressTableView?.delegate = self
        adressTableView?.dataSource = self
        view.addSubview(adressTableView!)
    }
    
    private func buildNullImageView() {
        nullImageView.backgroundColor = UIColor.clearColor()
        nullImageView.frame = CGRectMake(0, 0, 200, 200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: UIImage(named: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, 200, 20))
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(14)
        label.text = "你还没有地址哦~"
        nullImageView.addSubview(label)
    }
    
    private func loadAdressData() {
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count > 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableView?.hidden = false
                    tmpSelf!.adressTableView?.reloadData()
                    tmpSelf!.nullImageView.hidden = true
                    UserInfo.sharedUserInfo.setAllAdress(data!.data!)
                } else {
                    tmpSelf!.adressTableView?.hidden = true
                    tmpSelf!.nullImageView.hidden = false
                    UserInfo.sharedUserInfo.cleanAllAdress()
                }
            }
        }
    }
        
    private func buildBottomAddAdressButtom() {
        let bottomView = UIView(frame: CGRectMake(0, ScreenHeight - 60 - 64, ScreenWidth, 60))
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
    
        addAdressButton = UIButton(frame: CGRectMake(ScreenWidth * 0.15, 12, ScreenWidth * 0.7, 60 - 12 * 2))
        addAdressButton?.backgroundColor = LFBNavigationYellowColor
        addAdressButton?.setTitle("+ 新增地址", forState: UIControlState.Normal)
        addAdressButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addAdressButton?.layer.masksToBounds = true
        addAdressButton?.layer.cornerRadius = 8
        addAdressButton?.titleLabel?.font = UIFont.systemFontOfSize(15)
        addAdressButton?.addTarget(self, action: "addAdressButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(addAdressButton!)
    }
    
    // MARK: - Action
    func addAdressButtonClick() {
        let editVC = EditAdressViewController()
        editVC.topVC = self
        editVC.vcType = EditAdressViewControllerType.Add
        navigationController?.pushViewController(editVC, animated: true)
    }
}


extension MyAdressViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return adresses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        weak var tmpSelf = self
        let cell = AdressCell.adressCell(tableView, indexPath: indexPath) { (cellIndexPathRow) -> Void in
            let editAdressVC = EditAdressViewController()
            editAdressVC.topVC = tmpSelf
            editAdressVC.vcType = EditAdressViewControllerType.Edit
            editAdressVC.currentAdressRow = indexPath.row
            tmpSelf!.navigationController?.pushViewController(editAdressVC, animated: true)
        }
        cell.adress = adresses![indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isSelectVC {
            if selectedAdressCallback != nil {
                selectedAdressCallback!(adress: adresses![indexPath.row])
                navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}



