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
        scrollLabelView.initBasic()
        
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
            moreScrollLabelView.initBasic()
            
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
        self.scrollLabelView.changeValue()
        
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
    
    deinit {
        print("释放",self)
    }
}

class ScrollLabelView: UIView {
    
    let scrollView = UIScrollView()
    let currentLabel = UILabel()
    let underLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.backgroundColor = .lightGray
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        currentLabel.textAlignment = .center
        currentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(currentLabel)
        
        underLabel.textAlignment = .center
        underLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(underLabel)

    }
    
    func initBasic() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        scrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height * 2)
        currentLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        underLabel.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
        
        let textArray = [0,1,2,3,4,5,6,7,8,9]
        currentLabel.text = String(textArray[0])
    }
    
    func changeValue() {
        let underLabelValue = Int(self.currentLabel.text!)! + 1
        self.underLabel.text = String(underLabelValue)
        UIView.animate(withDuration: 0.3) {
            self.currentLabel.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
            self.underLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        } completion: { (Bool) in
            self.currentLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.underLabel.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
            self.currentLabel.text = String(underLabelValue)
            self.underLabel.text = "0"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
