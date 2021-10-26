//
//  FoldMenuViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/10/26.
//

import UIKit

class FoldMenuViewController: UIViewController,NavTitleProtocol,UITableViewDelegate,UITableViewDataSource,ClickMenuDelegate {

    var navTitle: String {return "FoldMenu"}
    
    let sideMenu = UITableView()
    let menuTitle = ["蔬菜","水果","肉类","水产"]
    let menuListTitle = [["茄子","包菜","青菜","花菜"],
                         ["苹果","梨","香蕉","葡萄"],
                         ["猪肉","牛肉","羊肉","鸡肉"],
                         ["螺蛳","螃蟹","鱼","虾"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        let segmentedControl = UISegmentedControl(items: ["单列","多列"])
        self.view.addSubview(segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(selectedSegmented), for: .valueChanged)
        segmentedControl.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(100)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        sideMenu.delegate = self
        sideMenu.dataSource = self
        sideMenu.register(UITableViewCell.self, forCellReuseIdentifier: "side")
        sideMenu.tableFooterView = UIView()
        self.view.addSubview(sideMenu)
        sideMenu.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(segmentedControl.snp.bottom).offset(20)
            ConstraintMaker.left.bottom.equalToSuperview()
            ConstraintMaker.width.equalTo(100)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deffaultIndex == 0 {
            if sectionClickIndex == section  {
                let arr : [String] = menuListTitle[sectionClickIndex!]
                return arr.count
            } else {
                return 0
            }
        } else {
            if sectionClickArray.contains(section) {
                let arr : [String] = menuListTitle[section]
                return arr.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sideCell = tableView.dequeueReusableCell(withIdentifier: "side", for: indexPath)
        
        if deffaultIndex == 0 {
            let arr : [String] = menuListTitle[sectionClickIndex!]
            sideCell.textLabel?.text = arr[indexPath.row]
        } else {
            if sectionClickArray.contains(indexPath.section) {
                let arr : [String] = menuListTitle[indexPath.section]
                sideCell.textLabel?.text = arr[indexPath.row]
            }
        }
        
        return sideCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let menuView = MenuView()
        
        menuView.menuButton.setTitle(menuTitle[section], for: .normal)
        menuView.menuButton.tag = section
        menuView.delegate = self
        
        return menuView
    }
    
    var deffaultIndex : Int = 0
    @objc func selectedSegmented(sender : UISegmentedControl) {
        deffaultIndex = sender.selectedSegmentIndex
    }
    
    var sectionClickIndex : Int?
    var sectionClickArray : NSMutableArray = []
    
    func didClickMenuButton(sender : UIButton) {
        if deffaultIndex == 0 {
            if sectionClickIndex == nil {
                sectionClickIndex = sender.tag
            } else {
                sectionClickIndex = nil
            }
        } else {
            if sectionClickArray.contains(sender.tag) {
                sectionClickArray.remove(sender.tag)
            } else {
                sectionClickArray.add(sender.tag)
            }
        }
        
        sideMenu.reloadData()
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

protocol ClickMenuDelegate : NSObjectProtocol {
    func didClickMenuButton(sender : UIButton)
}

class MenuView: UIView {
    weak var delegate : ClickMenuDelegate?
    let menuButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        menuButton.setTitleColor(.black, for: .normal)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        menuButton.layer.borderWidth = 1
        menuButton.layer.borderColor = UIColor.black.cgColor
        menuButton.layer.cornerRadius = 5
        menuButton.layer.masksToBounds = true
        menuButton.addTarget(self, action: #selector(clickMenuButton), for: .touchUpInside)
        self.addSubview(menuButton)
        menuButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 90, height: 40))
        }
    }
    
    @objc func clickMenuButton(sender : UIButton) {
        self.delegate?.didClickMenuButton(sender : sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
