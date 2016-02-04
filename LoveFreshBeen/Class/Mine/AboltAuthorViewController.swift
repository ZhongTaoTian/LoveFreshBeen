//
//  AboltAuthorViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class AboltAuthorViewController: BaseViewController {
    
    private var authorLabel: UILabel!
    private var gitHubLabel: UILabel!
    private var sinaWeiBoLabel: UILabel!
    private var blogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildAuthorImageView()
        
        bulidTextLabel()
        
        bulidGitHubLabel()
        
        bulidSinaLabel()
        
        bulidBlogLabel()
    
        buildURLButton()
    }
    
    // MARK: Build UI
    private func buildAuthorImageView() {
        navigationItem.title = "关于作者"
        
        let authorImageView = UIImageView(frame: CGRectMake((ScreenWidth - 100) * 0.5, 50, 100, 100))
        authorImageView.image = UIImage(named: "author")
        authorImageView.layer.masksToBounds = true
        authorImageView.layer.cornerRadius = 15
        view.addSubview(authorImageView)
    }
    
    private func bulidTextLabel() {
        authorLabel = UILabel()
        authorLabel.text = "维尼的小熊"
        authorLabel.sizeToFit()
        authorLabel.center.x = ScreenWidth * 0.5
        authorLabel.frame.origin.y = 170
        view.addSubview(authorLabel)
    }
    
    private func bulidGitHubLabel() {
        //frame: CGRectMake((ScreenWidth - gitHubLabel.width) * 0.5, CGRectGetMaxY(authorLabel.frame) + 10, gitHubLabel.width, gitHubLabel.height)
        gitHubLabel = UILabel()
        bulidTextLabel(gitHubLabel, text: "GitHub: " + "\(GitHubURLString)", tag: 1)
    }
    
    private func bulidSinaLabel() {
        sinaWeiBoLabel = UILabel()
        bulidTextLabel(sinaWeiBoLabel, text: "新浪微博: " + "\(SinaWeiBoURLString)", tag: 2)
    }
    private func bulidBlogLabel() {
        blogLabel = UILabel()
        bulidTextLabel(blogLabel, text: "技术博客: " + "\(BlogURLString)", tag: 3)
    }
    
    let buttonTitles = ["小熊的Github", "小熊的微博", "小熊的技术博客"]
    let btnW: CGFloat = 80
    private func buildURLButton() {
        for i in 0...2 {
            let btn = UIButton()
            btn.setTitle(buttonTitles[i], forState: .Normal)
            btn.backgroundColor = UIColor.whiteColor()
            btn.layer.cornerRadius = 5
            btn.tag = i
            btn.titleLabel?.font = UIFont.systemFontOfSize(10)
            btn.frame = CGRectMake(30 + CGFloat(i) * ((ScreenWidth - btnW * 3 - 60) / 2 + btnW), CGRectGetMaxY(blogLabel.frame) + 10, btnW, 30)
            btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            view.addSubview(btn)
        }
    }
    
    private func bulidTextLabel(label: UILabel, text: String, tag: Int) {
        label.text = text
        label.font = UIFont.systemFontOfSize(13)
        label.sizeToFit()
        label.userInteractionEnabled = true
        label.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        label.numberOfLines = 0
        
        switch tag {
        case 1: label.frame = CGRectMake(40, CGRectGetMaxY(authorLabel.frame) + 20, gitHubLabel.width, gitHubLabel.height + 10)
            break
        case 2: label.frame = CGRectMake(40, CGRectGetMaxY(gitHubLabel.frame) + 10, ScreenWidth, sinaWeiBoLabel.height + 10)
            break
        case 3: label.frame = CGRectMake(40, CGRectGetMaxY(sinaWeiBoLabel.frame) + 10, ScreenWidth - 40 - 50, 40)
        default:break
        }
        
        label.tag = tag
        view.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: "textLabelClick:")
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func textLabelClick(tap: UITapGestureRecognizer) {
        switch tap.view!.tag {
        case 1: UIApplication.sharedApplication().openURL(NSURL(string: GitHubURLString)!)
            break
        case 2: UIApplication.sharedApplication().openURL(NSURL(string: SinaWeiBoURLString)!)
            break
        default: UIApplication.sharedApplication().openURL(NSURL(string: BlogURLString)!)
            break
        }
    }
    
    func btnClick(sender: UIButton) {
        switch sender.tag {
        case 0: UIApplication.sharedApplication().openURL(NSURL(string: GitHubURLString)!)
            break
        case 1: UIApplication.sharedApplication().openURL(NSURL(string: SinaWeiBoURLString)!)
            break
        case 2: UIApplication.sharedApplication().openURL(NSURL(string: BlogURLString)!)
            break
        default: 
            break
        }
    }
    
}
