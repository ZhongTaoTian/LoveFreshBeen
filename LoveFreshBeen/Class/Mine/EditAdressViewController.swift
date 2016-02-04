//
//  EditAdressViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum EditAdressViewControllerType: Int {
    case Add
    case Edit
}

class EditAdressViewController: BaseViewController {
    
    private let deleteView = UIView()
    private let scrollView = UIScrollView()
    private let adressView = UIView()
    private var contactsTextField: UITextField?
    private var phoneNumberTextField: UITextField?
    private var cityTextField: UITextField?
    private var areaTextField: UITextField?
    private var adressTextField: UITextField?
    private var manButton: LeftImageRightTextButton?
    private var womenButton: LeftImageRightTextButton?
    private var selectCityPickView: UIPickerView?
    private var currentSelectedCityIndex = -1
    weak var topVC: MyAdressViewController?
    var vcType: EditAdressViewControllerType?
    var currentAdressRow: Int = -1
    
    private lazy var cityArray: [String]? = {
        let array = ["北京市", "上海市", "天津市", "广州市", "佛山市", "深圳市", "廊坊市", "武汉市", "苏州市", "无锡市"]
        return array
        }()
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildScrollView()
        
        buildAdressView()
        
        buildDeleteAdressView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        
        if currentAdressRow != -1 && vcType == .Edit {
            let adress = topVC!.adresses![currentAdressRow]
            contactsTextField?.text = adress.accept_name
            if adress.telphone?.characters.count == 11 {
                let telphone = adress.telphone! as NSString
                phoneNumberTextField?.text = telphone.substringWithRange(NSMakeRange(0, 3)) + " " + telphone.substringWithRange(NSMakeRange(3, 4)) + " " + telphone.substringWithRange(NSMakeRange(7, 4))
            }
            
            if adress.telphone?.characters.count == 13 {
                phoneNumberTextField?.text = adress.telphone
            }
            
            if adress.gender == "1" {
                manButton?.selected = true
            } else {
                womenButton?.selected = true
            }
            cityTextField?.text = adress.city_name
            let range = (adress.address! as NSString).rangeOfString(" ")
            areaTextField?.text = (adress.address! as NSString).substringToIndex(range.location)
            adressTextField?.text = (adress.address! as NSString).substringFromIndex(range.location + 1)
            
            deleteView.hidden = false
        }
        
    }
    
    // MARK: - Method
    private func buildNavigationItem() {
        
        navigationItem.title = "修改地址"
        
        let rightItemButton = UIBarButtonItem.barButton("保存", titleColor: UIColor.lightGrayColor(), target: self, action: "saveButtonClick")
        navigationItem.rightBarButtonItem = rightItemButton
    }
    
    private func buildDeleteAdressView() {
        deleteView.frame = CGRectMake(0, CGRectGetMaxY(adressView.frame) + 10, view.width, 50)
        deleteView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(deleteView)
        
        let deleteLabel = UILabel(frame: CGRectMake(0, 0, view.width, 50))
        deleteLabel.text = "删除当前地址"
        deleteLabel.textAlignment = NSTextAlignment.Center
        deleteLabel.font = UIFont.systemFontOfSize(15)
        deleteView.addSubview(deleteLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "deleteViewClick")
        deleteView.addGestureRecognizer(tap)
        deleteView.hidden = true
    }
    
    private func buildScrollView() {
        scrollView.frame = view.bounds
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func buildAdressView() {
        adressView.frame = CGRectMake(0, 10, view.width, 300)
        adressView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(adressView)
        
        let viewHeight: CGFloat = 50
        let leftMargin: CGFloat = 15
        let labelWidth: CGFloat = 70
        buildUnchangedLabel(CGRectMake(leftMargin, 0, labelWidth, viewHeight), text: "联系人")
        buildUnchangedLabel(CGRectMake(leftMargin, 2 * viewHeight, labelWidth, viewHeight), text: "手机号码")
        buildUnchangedLabel(CGRectMake(leftMargin, 3 * viewHeight, labelWidth, viewHeight), text: "所在城市")
        buildUnchangedLabel(CGRectMake(leftMargin, 4 * viewHeight, labelWidth, viewHeight), text: "所在地区")
        buildUnchangedLabel(CGRectMake(leftMargin, 5 * viewHeight, labelWidth, viewHeight), text: "详细地址")
        
        let lineView = UIView(frame: CGRectMake(leftMargin, 49, view.width - 10, 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGrayColor()
        adressView.addSubview(lineView)
        
        let textFieldWidth = view.width * 0.6
        let x = leftMargin + labelWidth + 10
        contactsTextField = UITextField()
        buildTextField(contactsTextField!, frame: CGRectMake(x, 0, textFieldWidth, viewHeight), placeholder: "收货人姓名", tag: 1)
        
        phoneNumberTextField = UITextField()
        buildTextField(phoneNumberTextField!, frame: CGRectMake(x, 2 * viewHeight, textFieldWidth, viewHeight), placeholder: "鲜蜂侠联系你的电话", tag: 2)
        
        cityTextField = UITextField()
        buildTextField(cityTextField!, frame: CGRectMake(x, 3 * viewHeight, textFieldWidth, viewHeight), placeholder: "请选择城市", tag: 3)
        
        areaTextField = UITextField()
        buildTextField(areaTextField!, frame: CGRectMake(x, 4 * viewHeight, textFieldWidth, viewHeight), placeholder: "请选择你的住宅,大厦或学校", tag: 4)
        
        adressTextField = UITextField()
        buildTextField(adressTextField!, frame: CGRectMake(x, 5 * viewHeight, textFieldWidth, viewHeight), placeholder: "请输入楼号门牌号等详细信息", tag: 5)
        
        manButton = LeftImageRightTextButton()
        buildGenderButton(manButton!, frame: CGRectMake(CGRectGetMinX(phoneNumberTextField!.frame), 50, 100, 50), title: "先生", tag: 101)
        
        womenButton = LeftImageRightTextButton()
        buildGenderButton(womenButton!, frame: CGRectMake(CGRectGetMaxX(manButton!.frame) + 10, 50, 100, 50), title: "女士", tag: 102)
    }
    
    private func buildUnchangedLabel(frame: CGRect, text: String) {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = LFBTextBlackColor
        adressView.addSubview(label)
        
        let lineView = UIView(frame: CGRectMake(15, frame.origin.y - 1, view.width - 10, 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGrayColor()
        adressView.addSubview(lineView)
    }
    
    private func buildTextField(textField: UITextField, frame: CGRect, placeholder: String, tag: Int) {
        textField.frame = frame
        
        if 2 == tag {
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        if 3 == tag {
            selectCityPickView = UIPickerView()
            selectCityPickView!.delegate = self
            selectCityPickView!.dataSource = self
            textField.inputView = selectCityPickView
            textField.inputAccessoryView = buildInputView()
        }
        
        textField.tag = tag
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.placeholder = placeholder
        textField.font = UIFont.systemFontOfSize(15)
        textField.delegate = self
        textField.textColor = LFBTextBlackColor
        adressView.addSubview(textField)
    }
    
    private func buildInputView() -> UIView {
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, view.width, 40))
        toolBar.backgroundColor = UIColor.whiteColor()
        
        let lineView = UIView(frame: CGRectMake(0, 0, view.width, 1))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        toolBar.addSubview(lineView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.alpha = 0.8
        titleLabel.text = "选择城市"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.frame = CGRectMake(0, 0, view.width, toolBar.height)
        toolBar.addSubview(titleLabel)
        
        let cancleButton = UIButton(frame: CGRectMake(0, 0, 80, toolBar.height))
        cancleButton.tag = 10
        cancleButton.addTarget(self, action: "selectedCityTextFieldDidChange:", forControlEvents: .TouchUpInside)
        cancleButton.setTitle("取消", forState: .Normal)
        cancleButton.setTitleColor(UIColor.colorWithCustom(82, g: 188, b: 248), forState: .Normal)
        toolBar.addSubview(cancleButton)
        
        let determineButton = UIButton(frame: CGRectMake(view.width - 80, 0, 80, toolBar.height))
        determineButton.tag = 11
        determineButton.addTarget(self, action: "selectedCityTextFieldDidChange:", forControlEvents: .TouchUpInside)
        determineButton.setTitleColor(UIColor.colorWithCustom(82, g: 188, b: 248), forState: .Normal)
        determineButton.setTitle("确定", forState: .Normal)
        toolBar.addSubview(determineButton)
        
        return toolBar
    }
    
    private func buildGenderButton(button: LeftImageRightTextButton, frame: CGRect, title: String, tag: Int) {
        button.tag = tag
        button.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        button.addTarget(self, action: "genderButtonClick:", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: UIControlState.Normal)
        button.frame = frame
        button.setTitleColor(LFBTextBlackColor, forState: .Normal)
        adressView.addSubview(button)
    }
    
    // MARK: - Action
    func saveButtonClick() {
        if contactsTextField?.text?.characters.count <= 1 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "我们需要你的大名~")
            return
        }
        
        if !manButton!.selected && !womenButton!.selected {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "人妖么,不男不女的~")
            return
        }
        
        if phoneNumberTextField!.text?.characters.count != 13 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "没电话,特么怎么联系你~")
            return
        }
        
        if cityTextField?.text?.characters.count <= 0 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "你在哪个城市啊~空空的~")
            return
        }
        
        if areaTextField?.text?.characters.count <= 2 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "你的位置啊~")
            return
        }
        
        if adressTextField?.text?.characters.count <= 2 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "在哪里呢啊~上哪找你去啊~")
            return
        }
        
        if vcType == .Add {
            let adress = Adress()
            setAdressModel(adress)
            if topVC?.adresses?.count == 0 || topVC?.adresses == nil {
                topVC?.adresses = []
            }
            
            topVC!.adresses!.insert(adress, atIndex: 0)
        }
        
        if vcType == .Edit {
            let adress = topVC!.adresses![currentAdressRow]
            setAdressModel(adress)
        }
        
        navigationController?.popViewControllerAnimated(true)
        topVC?.adressTableView?.reloadData()
    }
    
    private func setAdressModel(adress: Adress) {
        adress.accept_name = contactsTextField!.text
        adress.telphone = phoneNumberTextField!.text
        adress.gender = manButton!.selected ? "1" : "2"
        adress.city_name = cityTextField!.text
        adress.address = areaTextField!.text! + " " + adressTextField!.text!
    }
    
    func genderButtonClick(sender: UIButton) {
        
        switch sender.tag {
        case 101:
            manButton?.selected = true
            womenButton?.selected = false
            break
        case 102:
            manButton?.selected = false
            womenButton?.selected = true
            break
        default:
            break
        }
    }
    
    func selectedCityTextFieldDidChange(sender: UIButton) {
        
        if sender.tag == 11 {
            if currentSelectedCityIndex != -1 {
                cityTextField?.text = cityArray![currentSelectedCityIndex]
            }
        }
        cityTextField!.endEditing(true)
    }
    
    func deleteViewClick() {
        topVC!.adresses!.removeAtIndex(currentAdressRow)
        navigationController?.popViewControllerAnimated(true)
        topVC?.adressTableView?.reloadData()
    }
}


extension EditAdressViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 2 {
            if textField.text?.characters.count == 13 {
                
                return false
                
            } else {
                
                if textField.text?.characters.count == 3 || textField.text?.characters.count == 8 {
                    textField.text = textField.text! + " "
                }
                
                return true
            }
        }
        
        return true
    }
    
}

extension EditAdressViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray![row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedCityIndex = row
    }
    
}

