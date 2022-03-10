//
//  AnimationCollectionList.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/7/28.
//

import UIKit
import SnapKit

/// 通过 red 、 green 、blue 、alpha 颜色数值
public let RGBAlpa:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}

class AnimationCollectionList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var sectionArray = [""]
    var titleArray = ["Lottery","SpinOf3D","Skill","Bubble","MeterLabel","RollLabel","ButtonStyle","MoveCell","ButtonAnimation","RewardsPopup","FoldMenu","CountDown","PageMenu","AdvancingStyle","CustomizeTabBar"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "AnimationCollection"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "list")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
        
        requestData()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        
        listCell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        listCell.textLabel?.text = titleArray[indexPath.row]
        
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = VCFactory.create(index: indexPath.row) as! UIViewController
        if indexPath.row == 10 {
            if self.model != nil {
                let foldMenu : FoldMenuViewController = viewController as! FoldMenuViewController
                foldMenu.successModel = self.model
                self.navigationController?.pushViewController(foldMenu, animated: true)
            } else {
                print("稍后再试")
            }
        } else if indexPath.row == 12 {
            if self.model != nil {
                let pageMenu : PageMenuViewController = viewController as! PageMenuViewController
                pageMenu.successModel = self.model
                self.navigationController?.pushViewController(pageMenu, animated: true)
            } else {
                print("稍后再试")
            }
        } else if indexPath.row == 14 {
            let customizeTabBar : CustomizeTabBarViewController = viewController as! CustomizeTabBarViewController
            customizeTabBar.initConfiguration(bigIconArray: ["home_big","search_big","like_big","notice_big"],
                                              smallIconArrsy: ["home","search","like","notice"],
                                              titleArray: ["HOME","SEARCH","LIKE","NOTICE"],
                                              VCArray: [HomeViewController(),SearchViewController(),LikeViewController(),NoticeViewController()])
            self.navigationController?.pushViewController(customizeTabBar, animated: true)
        } else {
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    var model : SuccessModel? = nil
    func requestData() {
        PublicRequest.requestDataList { [weak self] (successModel) -> (Void) in
            self?.model = successModel
            self?.tableView.reloadData()
        }
    }

}






