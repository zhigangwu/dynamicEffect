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
    var titleArray = ["Lottery","SpinOf3D","Skill","Bubble","MeterLabel","RollLabel","ButtonStyle","MoveCell","ButtonAnimation","RewardsPopup","FoldMenu","CountDown","PageMenu"]

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
        self.navigationController?.pushViewController(Factory.create(index: indexPath.row) as! UIViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol NavTitleProtocol {
    var navTitle : String { get }
}

class Factory {
    static func create(index : Int) -> NavTitleProtocol {
        switch index {
        case 0:
            return LotteryViewController()
        case 1:
            return SpinOf3DViewController()
        case 2:
            return SkillViewController()
        case 3:
            return BubbleViewController()
        case 4:
            return MeterLabelViewController()
        case 5:
            return RollLabelViewController()
        case 6:
            return ButtonStyleViewController()
        case 7:
            return MoveCellViewController()
        case 8:
            return ButtonAnimationViewController()
        case 9:
            return RewardsPopupViewController()
        case 10:
            return FoldButtonAnimationViewController()
        case 11:
            return CountDownViewController()
        case 12:
            return PageMenuViewController()
        default:
            return LotteryViewController()
        }
    }
}




