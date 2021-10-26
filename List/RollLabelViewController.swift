//
//  RollLabelViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/8/19.
//

import UIKit

class RollLabelViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "RollLabel"}
    
    let scrollLabelView = ScrollLabelView()
    
    var viewArray : NSMutableArray = []
    
    let doubleValue = 63764
    var pointIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        //单个滚动
        scrollLabelView.backgroundColor = .blue
        scrollLabelView.currentLabel.text = "1"
        self.view.addSubview(scrollLabelView)
        scrollLabelView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview().offset(100)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        //多个滚动
        let moreView = UIView()
        moreView.backgroundColor = .lightGray
        self.view.addSubview(moreView)
        moreView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 25 * String(doubleValue).count , height: 25))
        }
        
        for i in 0..<String(doubleValue).count {
            let index1 = String(doubleValue).index(String(doubleValue).startIndex, offsetBy: i)

            let moreScrollLabelView = ScrollLabelView()
            moreScrollLabelView.tag = i
            moreScrollLabelView.currentLabel.text = String(String(doubleValue)[index1])
            if moreScrollLabelView.currentLabel.text == "." {
                pointIndex = i
            }
            moreView.addSubview(moreScrollLabelView)
            moreScrollLabelView.snp.makeConstraints { (ConstraintMaker) in
                ConstraintMaker.centerY.equalToSuperview()
                ConstraintMaker.left.equalToSuperview().offset(i * 25)
                ConstraintMaker.size.equalTo(CGSize(width: 25, height: 25))
            }
            
            viewArray.add(moreScrollLabelView)
        }

        let addButton = UIButton()
        addButton.setTitle("+1", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.centerY.equalToSuperview().offset(180)
            ConstraintMaker.size.equalTo(CGSize(width: 60, height: 25))
        }
    }
    
    @objc func clickAddButton() {
        let underLabelValue = Int(self.scrollLabelView.currentLabel.text!)! + 1
        self.scrollLabelView.underLabel.text = String(underLabelValue)
        UIView.animate(withDuration: 0.3) {
            self.scrollLabelView.currentLabel.frame = CGRect(x: 0, y: -25, width: 25, height: 25)
            self.scrollLabelView.underLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        } completion: { (Bool) in
            self.scrollLabelView.currentLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            self.scrollLabelView.underLabel.frame = CGRect(x: 0, y: 25, width: 25, height: 25)
            self.scrollLabelView.currentLabel.text = String(underLabelValue)
            self.scrollLabelView.underLabel.text = "0"
        }
        
        let indexInt : Int?
        if pointIndex != nil {
             indexInt = pointIndex! - 1
        } else {
            indexInt = String(doubleValue).count - 1
        }
        
        startScroll(index: indexInt!)
    }
    
    func startScroll(index : Int) {
        var moreScrollLabelView = ScrollLabelView()
        moreScrollLabelView = viewArray[index] as! ScrollLabelView
        
        var moreUnderLabelValue = Int(moreScrollLabelView.currentLabel.text!)! + 1
        if moreUnderLabelValue == 10 {
            moreScrollLabelView.currentLabel.text = "0"
            moreUnderLabelValue = 0
            startScroll(index: index - 1)
        }
        moreScrollLabelView.underLabel.text = String(moreUnderLabelValue)
        
        UIView.animate(withDuration: 0.3) {
            moreScrollLabelView.currentLabel.frame = CGRect(x: 0, y: -25, width: 25, height: 25)
            moreScrollLabelView.underLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        } completion: { (Bool) in
            moreScrollLabelView.currentLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            moreScrollLabelView.underLabel.frame = CGRect(x: 0, y: 25, width: 25, height: 25)
            moreScrollLabelView.currentLabel.text = String(moreUnderLabelValue)
            moreScrollLabelView.underLabel.text = String(moreUnderLabelValue + 1)
        }
    }
}

class ScrollLabelView: UIView {
    
    let scrollView = UIScrollView()
    let currentLabel = UILabel()
    let underLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textArray = [0,1,2,3,4,5,6,7,8,9]
        
        scrollView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        scrollView.backgroundColor = .lightGray
        scrollView.contentSize = CGSize(width: 25, height: 25 * 2)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        currentLabel.text = String(textArray[0])
        currentLabel.textAlignment = .center
        currentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(currentLabel)
        currentLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview()
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        underLabel.textAlignment = .center
        underLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(underLabel)
        underLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(25)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 25, height: 25))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class MoreScrollLabelView: UIView {
    
    let scrollView = UIScrollView()
    let geLabel = UILabel()
    let shiLabel = UILabel()
    let baiLabel = UILabel()
    let qianLabel = UILabel()
    let wanLabel = UILabel()
    let shiWanLabel = UILabel()
    let baiWanLabel = UILabel()
    let qianWanLabel = UILabel()
    
    let scrollLabelView = ScrollLabelView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        

    }
    
    func showNumber(valueStr : String){
//        let scan : Scanner = Scanner(string: valueStr)
//        var value : Int = 0
//        let bool = scan.scanInt(&value) && scan.isAtEnd
//        if bool == false { //不是整数
//
//        } else {
//
//        }
        
        for i in 0..<valueStr.count {
            let index1 = valueStr.index(valueStr.startIndex, offsetBy: i)

            scrollLabelView.currentLabel.text = String(valueStr[index1])
            self.addSubview(scrollLabelView)
            scrollLabelView.snp.makeConstraints { (ConstraintMaker) in
                ConstraintMaker.centerY.equalToSuperview()
                ConstraintMaker.left.equalToSuperview().offset(i * 25)
                ConstraintMaker.size.equalTo(CGSize(width: 25, height: 25))
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
