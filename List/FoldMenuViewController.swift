//
//  FoldButtonAnimationViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/10/26.
//

import UIKit
import Kingfisher

class FoldButtonAnimationViewController: UIViewController,NavTitleProtocol,UITableViewDelegate,UITableViewDataSource,ClickMenuDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

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
        
        layoutSideMenu()
        sideMenu2()
        sideMenu3()
    }
    
    func layoutSideMenu() {
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
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(260)
            ConstraintMaker.width.equalTo(100)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == sideMenu {
            return menuTitle.count
        } else if tableView == groupMenuTableView {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == sideMenu {
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
        } else if tableView == groupMenuTableView {
            return self.groupDataArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == sideMenu {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == sideMenu {
            let menuView = MenuView()
            
            menuView.menuButton.setTitle(menuTitle[section], for: .normal)
            menuView.menuButton.tag = section
            menuView.delegate = self
            
            return menuView
        }
        return UIView()
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
    
    // MARK: sideMenu2
    let menuButton = UIButton()
    let menuView = UIView()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    func sideMenu2() {
        
        menuButton.layer.cornerRadius = 8
        menuButton.layer.masksToBounds = true
        menuButton.backgroundColor = .lightGray
        menuButton.setImage(UIImage(named: "btn_arrow_up"), for: .normal)
        menuButton.addTarget(self, action: #selector(clickMenuButton), for: .touchUpInside)
        self.view.addSubview(menuButton)
        menuButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(sideMenu.snp.right).offset(20)
            ConstraintMaker.top.equalTo(sideMenu.snp.top).offset(160)
            ConstraintMaker.size.equalTo(CGSize(width: 50, height: 30))
        }
        
        menuView.alpha = 0
        menuView.backgroundColor = HexRGBAlpha(0x66ccff,1)
        menuView.layer.cornerRadius = 8
        menuView.layer.masksToBounds = true
        self.view.addSubview(menuView)
        menuView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(menuButton)
            ConstraintMaker.top.equalTo(menuButton.snp.bottom).offset(20)
            ConstraintMaker.size.equalTo(CGSize(width: 50, height: 185))
        }
        
        button1.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        button1.transform = CGAffineTransform(scaleX: 0, y: 0)
        button1.backgroundColor = HexRGBAlpha(0xFFA500,1)
        button1.layer.cornerRadius = 20
        button1.layer.masksToBounds = true
        menuView.addSubview(button1)
        
        button2.frame = CGRect(x: 5, y: 50, width: 40, height: 40)
        button2.transform = CGAffineTransform(scaleX: 0, y: 0)
        button2.backgroundColor = HexRGBAlpha(0xFF3E96,1)
        button2.layer.cornerRadius = 20
        button2.layer.masksToBounds = true
        menuView.addSubview(button2)
        
        button3.frame = CGRect(x: 5, y: 95, width: 40, height: 40)
        button3.transform = CGAffineTransform(scaleX: 0, y: 0)
        button3.backgroundColor = HexRGBAlpha(0xEE9572,1)
        button3.layer.cornerRadius = 20
        button3.layer.masksToBounds = true
        menuView.addSubview(button3)

        button4.frame = CGRect(x: 5, y: 140, width: 40, height: 40)
        button4.transform = CGAffineTransform(scaleX: 0, y: 0)
        button4.backgroundColor = HexRGBAlpha(0xE066FF,1)
        button4.layer.cornerRadius = 20
        button4.layer.masksToBounds = true
        menuView.addSubview(button4)
        
    }

    @objc func clickMenuButton(sender : UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.4) {
                self.menuView.alpha = 1
                self.menuView.frame = CGRect(x: self.menuView.frame.origin.x, y: self.menuView.frame.origin.y - 185 - 50 - 20, width: 50, height: 185)
            } completion: { (Bool) in

            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 0.1) {
                    self.button1.transform = CGAffineTransform(scaleX: 1, y: 1)
                }

                UIView.animate(withDuration: 0.15) {
                    self.button2.transform = CGAffineTransform(scaleX: 1, y: 1)
                }

                UIView.animate(withDuration: 0.2) {
                    self.button3.transform = CGAffineTransform(scaleX: 1, y: 1)
                }

                UIView.animate(withDuration: 0.25) {
                    self.button4.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.menuView.alpha = 0
                self.menuView.frame = CGRect(x: self.menuView.frame.origin.x, y: self.menuView.frame.origin.y + 185 + 50 + 20, width: 50, height: 185)
                
                self.button1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.button2.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.button3.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.button4.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } completion: { (Bool) in
                self.button1.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.button2.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.button3.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.button4.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
    }
    
    //MARK: ==================================sideMenu3==================================
    let groupMenuTableView = UITableView()
    let groupDataArray = ["A","B","C","D","E"]
    
    var collectionView : UICollectionView? = nil
    func sideMenu3() {
        groupMenuTableView.backgroundColor = .white
        groupMenuTableView.delegate = self
        groupMenuTableView.dataSource = self
        groupMenuTableView.separatorStyle = .none
        groupMenuTableView.layer.borderWidth = 1
        groupMenuTableView.layer.borderColor = UIColor.black.cgColor
        groupMenuTableView.layer.cornerRadius = 5
        groupMenuTableView.layer.masksToBounds = true
        groupMenuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "group")
        groupMenuTableView.tableFooterView = UIView()
        self.view.addSubview(groupMenuTableView)
        groupMenuTableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(sideMenu.snp.bottom).offset(20)
            ConstraintMaker.left.equalTo(sideMenu.snp.left)
            ConstraintMaker.size.equalTo(CGSize(width: 100, height: 44 * 5))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 50, height: 50)
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.layer.borderWidth = 1
        collectionView?.layer.borderColor = UIColor.black.cgColor
        collectionView?.layer.cornerRadius = 5
        collectionView?.layer.masksToBounds = true
        collectionView?.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "item")
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo(groupMenuTableView)
            ConstraintMaker.left.equalTo(groupMenuTableView.snp.right).offset(10)
            ConstraintMaker.right.equalToSuperview().offset(-10)
            ConstraintMaker.bottom.equalTo(groupMenuTableView)
        })
    }
    
    //MARK: ==================================tableViewCellForRowAt==================================
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sideMenu {
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
        } else {
            let groupCell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath)
             
            groupCell.textLabel?.textAlignment = .center
            groupCell.textLabel?.text = self.groupDataArray[indexPath.row]
            
            if groupIndex == indexPath.row {
                groupCell.backgroundColor = .purple
            } else {
                groupCell.backgroundColor = .clear
            }
            
            return groupCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == groupMenuTableView {
            groupIndex = indexPath.row
            tableView.reloadData()
            collectionView?.reloadData()
        }
    }
    
    
    //MARK: ==================================collectionViewDelegate==================================
    let itemArrays = [["https://car2.autoimg.cn/cardfs/series/g26/M0B/AE/B3/autohomecar__wKgHEVs9u5WAV441AAAKdxZGE4U148.png",
                       "https://car2.autoimg.cn/cardfs/series/g26/M05/B0/29/autohomecar__ChcCP1s9u5qAemANAABON_GMdvI451.png",
                       "https://car2.autoimg.cn/cardfs/series/g21/M06/5F/75/autohomecar__ChsEdmATuFGAJ6LHAAAMk3ugjWo809.png",
                       "https://car3.autoimg.cn/cardfs/series/g24/M01/82/2B/autohomecar__ChwFjl7LjQ2AP3opAAAZdf47yLI833.png",
                       "https://car2.autoimg.cn/cardfs/series/g24/M08/0F/C6/autohomecar__Chtk3WCrG-KAFes4AAAHQi7g7mc829.png",
                       "https://car3.autoimg.cn/cardfs/series/g27/M00/FB/E1/autohomecar__ChsEnVzmW--AExZ6AABfZsjdIhI251.png",
                       "https://car3.autoimg.cn/cardfs/series/g27/M05/AB/2E/autohomecar__wKgHHls8hiKADrqGAABK67H4HUI503.png",
                       "https://car3.autoimg.cn/cardfs/series/g30/M07/B0/47/autohomecar__wKgHPls9vLOAHILAAAAWGGhA_W0282.png"],
                      ["https://car3.autoimg.cn/cardfs/series/g26/M00/AF/E7/autohomecar__wKgHHVs9u6mAaY6mAAA2M840O5c440.png",
                       "https://car2.autoimg.cn/cardfs/series/g8/M05/78/7D/autohomecar__ChsEwGDymG6ATewSAAAMXREb5AQ823.png",
                       "https://car2.autoimg.cn/cardfs/series/g1/M08/18/4F/autohomecar__ChsEmV5fMd6AZK-bAAAg8taR7xI407.png",
                       "https://car2.autoimg.cn/cardfs/series/g24/M04/A1/26/autohomecar__ChwFjmDJkXaAUvLTAAAHQmdx1V4583.png",
                       "https://car3.autoimg.cn/cardfs/series/g27/M04/61/EC/autohomecar__ChsEfFzCyuGAasIhAABhYRrAZ-M141.png",
                       "https://car3.autoimg.cn/cardfs/series/g2/M02/2A/97/autohomecar__ChsEkF7Dp1mAZ9jIAAAUTcLHE7s133.png",
                       "https://car2.autoimg.cn/cardfs/series/g24/M04/C9/71/autohomecar__ChwFjmC0hm6AC0CtAAA25rbWpqA875.png"],
                      ["https://car3.autoimg.cn/cardfs/series/g28/M06/44/F5/autohomecar__ChwFkl9y_JqAVybMAAAUINDQ2uo180.png",
                       "https://car3.autoimg.cn/cardfs/series/g30/M00/AF/12/autohomecar__wKgHHFs9s9OAOb66AAAYgXAgE6Q888.png",
                       "https://car2.autoimg.cn/cardfs/series/g30/M0B/5C/88/autohomecar__ChsEf1_llNOAIrJgAAAQANAIBSA602.png",
                       "https://car2.autoimg.cn/cardfs/series/g29/M09/4F/71/autohomecar__ChsEfl56zDqADVh1AAAthoSARhM901.png",
                       "https://car2.autoimg.cn/cardfs/series/g29/M02/AA/69/autohomecar__wKgHJFs8gvyAIOjpAAAP8QDmnsg975.png"],
                      ["https://car2.autoimg.cn/cardfs/series/g24/M07/57/D8/autohomecar__ChsEeV26zOKAATwCAAAMlhPv54M195.png",
                       "https://car2.autoimg.cn/cardfs/series/g30/M02/F9/F0/autohomecar__ChcCSV38aQSAUL_RAAB_z1788XE540.png",
                       "https://car3.autoimg.cn/cardfs/series/g25/M09/50/8C/autohomecar__ChsEmF9xTy2AbSE3AAAT8bSy-30433.png",
                       "https://car3.autoimg.cn/cardfs/series/g24/M05/60/3B/autohomecar__ChwFjmDCtHeADhPVAAAaNKkqdAA838.png",
                       "https://car2.autoimg.cn/cardfs/series/g29/M07/51/B9/autohomecar__ChsEflvzc-CAQAjsAAAcpo1Owuo575.png",
                       "https://car3.autoimg.cn/cardfs/series/g29/M07/AB/4F/autohomecar__wKgHJFs8ntuAMyzLAAAiej-Yyi4735.png",
                       "https://car3.autoimg.cn/cardfs/series/g1/M0A/BA/5C/autohomecar__ChsEmV7d8LqAD7upAAAlhzwMg2c093.png",
                       "https://car2.autoimg.cn/cardfs/series/g30/M00/AF/14/autohomecar__wKgHHFs9s_KAaauXAAAa0T_XCnU027.png",
                       "https://car2.autoimg.cn/cardfs/series/g10/M11/A0/BA/autohomecar__ChsE8V_lqsuAfDh_AABItIlAeNM038.png",
                       "https://car3.autoimg.cn/cardfs/series/g28/M02/B0/57/autohomecar__wKgHI1s9uNeAb52AAAASYiac9j0595.png"],
                      ["https://car2.autoimg.cn/cardfs/series/g26/M00/C9/FA/autohomecar__ChxkjmF7W0aAMzb0AAAGiT8-x8g870.png",
                       "https://car2.autoimg.cn/cardfs/series/g5/M0D/2A/82/autohomecar__ChwEl2E22UqAArxVAAAWH9Z3-BU959.png",
                       "https://car2.autoimg.cn/cardfs/series/g5/M0D/2A/82/autohomecar__ChwEl2E22UqAArxVAAAWH9Z3-BU959.png",
                       "https://car3.autoimg.cn/cardfs/series/g29/M01/AB/A0/autohomecar__wKgHJFs8rvuABvjcAAATebzQNMg932.png",
                       ]]
    var groupIndex : Int? = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let array : Array<Any> = self.itemArrays[groupIndex!]
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemCollectionViewCell
        
        let array : Array<Any> = self.itemArrays[groupIndex!]
        itemCell.itemIcon.kf.setImage(with: URL(string: array[indexPath.row] as! String))
        
        return itemCell
    }
    
    deinit {
        print("释放",self)
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

class ItemCollectionViewCell: UICollectionViewCell {
    
    let itemIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemIcon.layer.borderWidth = 0.5
        itemIcon.layer.borderColor = UIColor.black.cgColor
        self.contentView.addSubview(itemIcon)
        itemIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
