//
//  CustomizeTabBarViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2022/1/26.
//

import UIKit



class CustomizeTabBarViewController: UITabBarController,NavTitleProtocol,UITabBarControllerDelegate {
    
    var navTitle: String {return "CustomizeTabBar"}
    
    private let bigItem = UIImageView()
    
    private var bigIconArray : NSMutableArray = []
    private let bigItemBackgroundColor = [ColorFactory.select(type: .backgroundColor_1),
                                          ColorFactory.select(type: .backgroundColor_2),
                                          ColorFactory.select(type: .backgroundColor_3),
                                          ColorFactory.select(type: .backgroundColor_4)]
    private var smallIconArrsy : NSMutableArray = []
    private var titleArray : NSMutableArray = []
    
    private let itemIconArray : NSMutableArray = []
    private let itemTitleArray : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        self.navigationItem.title = navTitle
        self.delegate = self
        
        self.tabBar.tintColor = ColorFactory.select(type: .titleColor_1)
    }
    
    func initConfiguration(bigIconArray : Array<String>, smallIconArrsy : Array<String>, titleArray : Array<String>, VCArray : Array<UIViewController>) {
        self.bigIconArray.addObjects(from: bigIconArray)
        self.smallIconArrsy.addObjects(from: smallIconArrsy)
        self.titleArray.addObjects(from: titleArray)
        
        for viewController in VCArray {
            self.addChild(viewController)
        }
        
        layoutMainView()
    }
    
    func layoutMainView() {
        
        let itemSpacing = (WIDTH - CGFloat(60 * self.viewControllers!.count)) / 5
                
        let mainView = UIView()
        mainView.backgroundColor = .clear
        self.tabBar.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(120)
        }
        
        bigItem.image = UIImage(named: "home_big")
        bigItem.frame = CGRect(x: itemSpacing, y: -30, width: 60, height: 60)
        bigItem.backgroundColor = ColorFactory.select(type: .backgroundColor_1)
        bigItem.layer.cornerRadius = 5
        bigItem.layer.masksToBounds = true
        bigItem.contentMode = .scaleAspectFit
        bigItem.layer.borderWidth = 6
        bigItem.layer.borderColor = ColorFactory.select(type: .backgroundColor_1).cgColor
        
        self.tabBar.addSubview(bigItem)
        
        for i in 0..<self.viewControllers!.count {
            let itemIcon = UIImageView()
            itemIcon.backgroundColor = .clear
            
            if i == 0 {
                itemIcon.frame = CGRect(x: itemSpacing + 15 , y: -15, width: 30, height: 30)
            } else {
                let spacing = itemSpacing * CGFloat(i + 1)
                let nSpacing = 15 * CGFloat(1 + 4 * i)
                itemIcon.frame = CGRect(x: spacing + nSpacing , y: 15, width: 30, height: 30)
            }
            itemIcon.image = UIImage(named: smallIconArrsy[i] as! String)
            self.tabBar.addSubview(itemIcon)
            itemIconArray.add(itemIcon)
            
            let itemTitle = UILabel()
            itemTitle.text = titleArray[i] as! String
            itemTitle.textAlignment = .center
            itemTitle.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            itemTitle.textColor = bigItemBackgroundColor[i]
            self.tabBar.addSubview(itemTitle)
            itemTitle.snp.makeConstraints { make in
                make.centerX.equalTo(itemIcon)
                make.centerY.equalToSuperview()
            }
            itemTitleArray.add(itemTitle)
            if i == 0 {
                itemTitle.isHidden = false
            } else {
                itemTitle.isHidden = true
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        changeBigItemBorderColor(index: self.selectedIndex)
    }
    
    func changeBigItemBorderColor(index : Int) {
        let itemSpacing = (WIDTH - CGFloat(60 * self.viewControllers!.count)) / 5
        
        bigItem.image = UIImage(named: bigIconArray[index] as! String)
        bigItem.backgroundColor = bigItemBackgroundColor[index]
        
        UIView.animate(withDuration: 0.3) { [self] in
            self.bigItem.frame = CGRect(x: itemSpacing + (60 + itemSpacing) * CGFloat(index) , y: -30, width: 60, height: 60)
            
            for i in 0..<self.viewControllers!.count {
                let itemIcon : UIImageView = itemIconArray[i] as! UIImageView
                let itemtitle : UILabel = itemTitleArray[i] as! UILabel
                
                let spacing = itemSpacing * CGFloat(i + 1)
                let nSpacing = 15 * CGFloat(1 + 4 * i)
                
                if i == index {
                    itemIcon.frame = CGRect(x: spacing + nSpacing , y: -15, width: 30, height: 30)
                    itemtitle.isHidden = false
                } else {
                    itemIcon.frame = CGRect(x: spacing + nSpacing , y: 15, width: 30, height: 30)
                    itemtitle.isHidden = true
                }
            }

        } completion: { Bool in

        }
        
        if index == 0 {
            tabBar.tintColor = ColorFactory.select(type: .backgroundColor_1)
            bigItem.layer.borderColor = self.tabBar.tintColor.cgColor
        } else if index == 1 {
            self.tabBar.tintColor = ColorFactory.select(type: .backgroundColor_2)
            bigItem.layer.borderColor = self.tabBar.tintColor.cgColor
        } else if index == 2 {
            self.tabBar.tintColor = ColorFactory.select(type: .backgroundColor_3)
            bigItem.layer.borderColor = self.tabBar.tintColor.cgColor
        } else if index == 3 {
            self.tabBar.tintColor = ColorFactory.select(type: .backgroundColor_4)
            bigItem.layer.borderColor = self.tabBar.tintColor.cgColor
        }
    }
}

class HomeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorFactory.select(type: .backgroundColor_1)
    }
    
}

class SearchViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorFactory.select(type: .backgroundColor_2)
    }
    
}

class LikeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorFactory.select(type: .backgroundColor_3)
    }
    
}

class NoticeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorFactory.select(type: .backgroundColor_4)
    }
    
}

