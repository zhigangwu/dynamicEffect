//
//  FoldButtonAnimationViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/10/26.
//

import UIKit
import Kingfisher

class FoldMenuViewController: UIViewController,NavTitleProtocol,UITableViewDelegate,UITableViewDataSource,ClickMenuDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var navTitle: String {return "FoldMenu"}
    
    var successModel : SuccessModel? = nil
    let sideMenu = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        layoutSideMenu()
        sideMenu2()
        sideMenu3()
        
        requestData()
    }
    
    func requestData() {
        if self.successModel != nil {
            let infoArray : Array<InfoModel> = self.successModel!.successModelOfInfo
            for infoModel in infoArray {
                if !self.groupDataArray.contains(infoModel.infoOfFirstletter ?? "") {
                    self.groupDataArray.add(infoModel.infoOfFirstletter ?? "")
                }
            }
            
            for firstletter in self.groupDataArray {
                let array : NSMutableArray = []
                for infoModel in infoArray {
                    if (firstletter as! String) == infoModel.infoOfFirstletter {
                        array.add(infoModel)
                    }
                }
                self.itemArrays.add(array)
            }
            
            self.collectionView?.reloadData()
            self.sideMenu.reloadData()
            self.groupMenuTableView.reloadData()
        }
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
            return groupDataArray.count
        } else if tableView == groupMenuTableView {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == sideMenu {
            if deffaultIndex == 0 {
                if sectionClickIndex == section  {
                    let arr : Array<InfoModel> = self.itemArrays[sectionClickIndex!] as! Array<InfoModel>
                    return arr.count
                } else {
                    return 0
                }
            } else {
                if sectionClickArray.contains(section) {
//                    let arr : [String] = self.itemArrays[section] as! [String]
                    let arr : Array<InfoModel> = self.itemArrays[section] as! Array<InfoModel>
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
            
            menuView.backgroundColor = .white
            menuView.menuButton.setTitle((self.groupDataArray[section] as! String), for: .normal)
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
    let groupDataArray : NSMutableArray = []
    
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
            
            sideCell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            
            if deffaultIndex == 0 {
                let arr : Array<InfoModel> = self.itemArrays[sectionClickIndex!] as! Array<InfoModel>
                let infoModel = arr[indexPath.row]
                sideCell.textLabel?.text = infoModel.infoOfName
            } else {
                if sectionClickArray.contains(indexPath.section) {
                    let arr : Array<InfoModel> = self.itemArrays[indexPath.section] as! Array<InfoModel>
                    let infoModel = arr[indexPath.row]
                    sideCell.textLabel?.text = infoModel.infoOfName
                }
            }
            
            return sideCell
        } else {
            let groupCell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath)
             
            groupCell.textLabel?.textAlignment = .center
            groupCell.textLabel?.text = (self.groupDataArray[indexPath.row] as! String)
            
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
    let itemArrays : NSMutableArray = []
    var groupIndex : Int? = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.itemArrays.count != 0 {
            let array : Array<Any> = self.itemArrays[groupIndex!] as! Array<Any>
            return array.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemCollectionViewCell
        
        if self.itemArrays.count != 0 {
            let array : Array<InfoModel> = self.itemArrays[groupIndex!] as! Array<InfoModel>
            let infoModel = array[indexPath.row]
            itemCell.itemIcon.kf.setImage(with: URL(string: "https:" + infoModel.infoOfImg!))
        }
        
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
