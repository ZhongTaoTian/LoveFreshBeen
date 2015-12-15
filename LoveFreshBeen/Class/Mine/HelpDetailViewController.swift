//
//  HelpDetailViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/14.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HelpDetailViewController: BaseViewController {
    
    private var questionTableView: LFBTableView?
    private var questions: [Question]?
    private var lastOpenIndex = -1
    private var isOpenCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "常见问题"
        view.backgroundColor = UIColor.whiteColor()
        
        buildQuestionTableView()
        
        loadHelpData()
    }
    
    private func buildQuestionTableView() {
        questionTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        questionTableView?.backgroundColor = UIColor.whiteColor()
        questionTableView?.registerClass(HelpHeadView.self, forHeaderFooterViewReuseIdentifier: "headView")
        questionTableView?.sectionHeaderHeight = 50
        questionTableView!.delegate = self
        questionTableView!.dataSource = self
        questionTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        view.addSubview(questionTableView!)
    }
    
    private func loadHelpData() {
        weak var tmpSelf = self
        
        Question.loadQuestions { (questions) -> () in
            tmpSelf!.questions = questions
            tmpSelf!.questionTableView?.reloadData()
        }
    }
}


extension HelpDetailViewController: UITableViewDelegate, UITableViewDataSource, HelpHeadViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = AnswerCell.answerCell(tableView)
        cell.question = questions![indexPath.section]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastOpenIndex == section && isOpenCell {
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if lastOpenIndex == indexPath.section && isOpenCell {
            return questions![indexPath.section].cellHeight
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headView") as? HelpHeadView
        headView!.tag = section
        headView?.delegate = self
        let question = questions![section]
        headView?.question = question
        
        return headView!
    }
    
    func headViewDidClck(headView: HelpHeadView) {
        if lastOpenIndex != -1 && lastOpenIndex != headView.tag && isOpenCell {
            let headView = questionTableView?.headerViewForSection(lastOpenIndex) as? HelpHeadView
            headView?.isSelected = false
            
            let deleteIndexPaths = [NSIndexPath(forRow: 0, inSection: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        

        if lastOpenIndex == headView.tag && isOpenCell {
            let deleteIndexPaths = [NSIndexPath(forRow: 0, inSection: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            return
        }
        
        lastOpenIndex = headView.tag
        isOpenCell = true
        let insertIndexPaths = [NSIndexPath(forRow: 0, inSection: headView.tag)]
        questionTableView?.insertRowsAtIndexPaths(insertIndexPaths, withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

