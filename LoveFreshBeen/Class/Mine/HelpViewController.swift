//
//  HelpViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum HelpCellType: Int {
    case Phone = 0
    case Question = 1
}

class HelpViewController: BaseViewController {

    let margin: CGFloat = 20
    let backView: UIView = UIView(frame: CGRectMake(0, 10, ScreenWidth, 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "客服帮助"
        
        backView.backgroundColor = UIColor.whiteColor()
        view.addSubview(backView)
        
        let phoneLabel = UILabel(frame: CGRectMake(20, 0, ScreenWidth - margin, 50))
        creatLabel(phoneLabel, text: "客服电话: 400-8484-842", type: .Phone)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRectMake(ScreenWidth - 20, (50 - 10) * 0.5, 5, 10)
        backView.addSubview(arrowImageView)
        
        let lineView = UIView(frame: CGRectMake(margin, 49.5, ScreenWidth - margin, 1))
        lineView.backgroundColor = UIColor.grayColor()
        lineView.alpha = 0.2
        backView.addSubview(lineView)
        
        let questionLabel = UILabel(frame: CGRectMake(margin, 50, ScreenWidth - margin, 50))
        creatLabel(questionLabel, text: "常见问题", type: .Question)
        
        let arrowImageView2 = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView2.frame = CGRectMake(ScreenWidth - 20, (50 - 10) * 0.5 + 50, 5, 10)
        backView.addSubview(arrowImageView2)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK - Method
    private func creatLabel(label: UILabel, text: String, type: HelpCellType) {
        label.text = text
        label.userInteractionEnabled = true
        label.font = UIFont.systemFontOfSize(15)
        label.tag = type.hashValue
        backView.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: "cellClick:")
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func cellClick(tap: UITapGestureRecognizer) {
     
        switch tap.view!.tag {
        case HelpCellType.Phone.hashValue :
            let alertView = UIAlertView(title: "", message: "400-8484-842", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "拨打")
            alertView.show()
            break
        case HelpCellType.Question.hashValue :
            let helpDetailVC = HelpDetailViewController()
            navigationController?.pushViewController(helpDetailVC, animated: true)
            break
        default : break
        }
        
    }
    
}

extension HelpViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel:4008484842")!)
        }
    }
}
