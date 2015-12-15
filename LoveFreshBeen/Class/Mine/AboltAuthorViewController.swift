//
//  AboltAuthorViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/11.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

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
    
    
    
}
