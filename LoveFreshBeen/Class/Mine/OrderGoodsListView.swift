//
//  OrderGoodsListView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class OrderGoodsListView: UIView {
    
    private let costLabel = UILabel()
    private let goodsListView = OrderGoodsView()
    private let feeListView = FeeListView()
    private let lineView1 = UIView()
    private let payMoneyLabel = UILabel()
    private let payLabel = UILabel()
    private let backView = UIView()
    weak var delegate: OrderGoodsListViewDelegate?
    
    var orderGoodsViewHeight: CGFloat = 0 {
        didSet  {
            layoutSubviews()
        }
    }
    
    var feeListViewHeight: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    var order: Order? {
        didSet {
            goodsListView.order_goods = order!.order_goods
            orderGoodsViewHeight = goodsListView.orderGoodsViewHeight
            feeListView.fee_list = order!.fee_list
            feeListViewHeight = feeListView.feeListViewHeight
            payMoneyLabel.text = "$" + (order?.real_amount)!
            payLabel.text = "实付"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        costLabel.textColor = UIColor.lightGrayColor()
        costLabel.font = UIFont.systemFontOfSize(12)
        costLabel.text = "费用明细"
        addSubview(costLabel)
        
        addSubview(goodsListView)
        
        lineView1.alpha = 0.1
        lineView1.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView1)
        
        addSubview(feeListView)
        
        backView.backgroundColor = UIColor.whiteColor()
        addSubview(backView)
        
        payMoneyLabel.textColor = UIColor.redColor()
        payMoneyLabel.font = UIFont.systemFontOfSize(14)
        payMoneyLabel.textAlignment = NSTextAlignment.Right
        addSubview(payMoneyLabel)
        
        payLabel.textAlignment = NSTextAlignment.Right
        payLabel.textColor = LFBTextBlackColor
        payLabel.font = UIFont.systemFontOfSize(14)
        addSubview(payLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 10
        costLabel.frame = CGRectMake(leftMargin, 0, width - leftMargin, 30)
        lineView1.frame = CGRectMake(leftMargin, CGRectGetMaxY(costLabel.frame), width - leftMargin, 1)
        goodsListView.frame = CGRectMake(0, CGRectGetMaxY(costLabel.frame), width, orderGoodsViewHeight)
        feeListView.frame = CGRectMake(0, CGRectGetMaxY(goodsListView.frame), width, feeListViewHeight)
        payMoneyLabel.frame = CGRectMake(width - 100 - 10, CGRectGetMaxY(feeListView.frame), 100, 40)
        payLabel.frame = CGRectMake(CGRectGetMinX(payMoneyLabel.frame) - 60, CGRectGetMaxY(feeListView.frame), 60, 40)
        backView.frame = CGRectMake(0, CGRectGetMaxY(feeListView.frame), width, 40)
        
        if delegate != nil {
            delegate!.orderGoodsListViewHeightDidChange(CGRectGetMaxY(backView.frame))
        }
    }
    
}

protocol OrderGoodsListViewDelegate: NSObjectProtocol {
    func orderGoodsListViewHeightDidChange(height: CGFloat);
}

class OrderGoodsView: UIView {
    
    var orderGoodsViewHeight: CGFloat = 0
    
    private var lastViewY: CGFloat = 0
    
    var order_goods: [[OrderGoods]]? {
        didSet {
            for i in 0..<order_goods!.count {
                let array = order_goods![i]
                if array.count == 1 {
                    let goodsView = GoodsView(frame: CGRectMake(0, lastViewY + 10, ScreenWidth, 20))
                    orderGoodsViewHeight += 40
                    goodsView.orderGoods = array[0]
                    lastViewY = CGRectGetMaxY(goodsView.frame) + 10
                    addSubview(goodsView)
                } else if array.count > 1 {
                    orderGoodsViewHeight = orderGoodsViewHeight + CGFloat(array.count) * 20 + 20
                    for i in 0..<array.count {
                        let goodsView = GoodsView()
                        if i == 0 {
                            goodsView.frame = CGRectMake(0, lastViewY + 10, ScreenWidth, 20)
                            lastViewY = CGRectGetMaxY(goodsView.frame)
                        } else {
                            goodsView.frame = CGRectMake(0, lastViewY, ScreenWidth, 20)
                            lastViewY = CGRectGetMaxY(goodsView.frame) + 10
                        }
                        goodsView.orderGoods = array[i]
                        addSubview(goodsView)
                    }
                }
                let lineView = UIView()
                lineView.alpha = 0.1
                lineView.backgroundColor = UIColor.lightGrayColor()
                lineView.frame = CGRectMake(10, orderGoodsViewHeight, ScreenWidth - 10, 1)
                addSubview(lineView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}


class GoodsView: UIView {
    
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    let priceLabel = UILabel()
    let giftImageView = UIImageView()
    
    var isShowImageView = false
    
    var orderGoods: OrderGoods? {
        didSet {
            titleLabel.text = orderGoods?.name
            numberLabel.text = "x" + (orderGoods?.goods_nums)!
            priceLabel.text = "$" + (orderGoods?.goods_price)!.cleanDecimalPointZear()
            if orderGoods?.is_gift != -1 {
                if orderGoods!.is_gift == 0 {
                    giftImageView.hidden = true
                    isShowImageView = false
                    layoutSubviews()
                } else if orderGoods!.is_gift == 1 {
                    giftImageView.hidden = false
                    isShowImageView = true
                    priceLabel.hidden = true
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20))

        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = LFBTextBlackColor
        addSubview(titleLabel)
        
        numberLabel.font = UIFont.systemFontOfSize(14)
        numberLabel.textColor = LFBTextBlackColor
        addSubview(numberLabel)
        
        priceLabel.font = UIFont.systemFontOfSize(14)
        priceLabel.textColor = LFBTextBlackColor
        priceLabel.textAlignment = NSTextAlignment.Right
        addSubview(priceLabel)
        
        giftImageView.hidden = true
        giftImageView.image = UIImage(named: "jingxuan.png")
        addSubview(giftImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isShowImageView {
            giftImageView.frame = CGRectMake(10, (height - 15) * 0.5, 40, 15)
            titleLabel.frame = CGRectMake(CGRectGetMaxX(giftImageView.frame) + 5, 0, width * 0.6, height)
            numberLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10 - 45, 0, 30, height)
        } else {
            titleLabel.frame = CGRectMake(10, 0, width * 0.6, height)
            numberLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10, 0, 30, height)
        }
        priceLabel.frame = CGRectMake(width - 60 - 10, 0, 60, 20)
    }
    
}

class FeeListView: UIView {
    
    let lineView1 = UIView()
    let lineView2 = UIView()
    
    var feeListViewHeight: CGFloat = 20
    var fee_list: [OrderFeeList]? {
        didSet {
            if fee_list?.count > 1 {
                for i in 0..<fee_list!.count {
                    let feelView = FeeView(frame: CGRectMake(0, 10 + CGFloat(i) * 25, ScreenWidth, 25), fee: fee_list![i])
                    feeListViewHeight += 25
                    addSubview(feelView)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        lineView1.alpha = 0.1
        lineView1.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView1)
        
        lineView2.alpha = 0.1
        lineView2.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView1.frame = CGRectMake(10, 0, width - 10, 1)
        lineView2.frame = CGRectMake(10, feeListViewHeight - 1, width - 10, 1)
    }
}

class FeeView: UIView {
    
    private let titleLabel = UILabel()
    private let prictLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        titleLabel.textColor = LFBTextBlackColor
        titleLabel.font = UIFont.systemFontOfSize(14)
        addSubview(titleLabel)
        
        prictLabel.textColor = LFBTextBlackColor
        prictLabel.textAlignment = NSTextAlignment.Right
        prictLabel.font = UIFont.systemFontOfSize(14)
        addSubview(prictLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, fee: OrderFeeList) {
        self.init(frame: frame)
        titleLabel.text = fee.text
        prictLabel.text = "$" + (fee.value?.cleanDecimalPointZear())!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRectMake(10, 0, width - 100, 25)
        prictLabel.frame = CGRectMake(width - 150, 0, 140, 25)
    }
}








