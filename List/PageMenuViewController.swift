//
//  PageMenuViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/12/16.
//

import UIKit

class PageMenuViewController: UIViewController,NavTitleProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    

    var navTitle: String {return "PageMenu"}
    
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView? = nil
    let titleArray : NSMutableArray = []
    
    var itemWidth : CGFloat = 80
    var defaultSelectIndex : Int? = 0
    
    let unfoldButton = UIButton()
    let unfoldIcon = UIImageView()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isPagingEnabled = false
        collectionView?.layer.borderWidth = 0.5
        collectionView?.layer.borderColor = UIColor.lightGray.cgColor
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(PageMenuCollectionViewCell.self, forCellWithReuseIdentifier: "PageMenu")
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(88)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.right.equalToSuperview().offset(-50)
            ConstraintMaker.height.equalTo(50)
        })
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        unfoldButton.layer.borderWidth = 0.5
        unfoldButton.layer.borderColor = UIColor.lightGray.cgColor
        unfoldButton.addTarget(self, action: #selector(unfoldCollectionView), for: .touchUpInside)
        self.view.addSubview(unfoldButton)
        unfoldButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(collectionView!)
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        unfoldIcon.image = UIImage(named: "箭头")
        unfoldIcon.contentMode = .scaleAspectFit
        unfoldButton.addSubview(unfoldIcon)
        unfoldIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "list")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(88 + 50)
            ConstraintMaker.left.right.bottom.equalToSuperview()
        }
        self.view.sendSubviewToBack(tableView)
        
        requestData()
    }
    
    func requestData() {
        PublicRequest.requestDataList { [weak self] (successModel) -> (Void) in
            let infoArray : Array<InfoModel> = successModel.successModelOfInfo
            
            for infoModel in infoArray {
                if !self!.titleArray.contains(infoModel.infoOfFirstletter ?? "") {
                    self!.titleArray.add(infoModel.infoOfFirstletter ?? "")
                }
            }
            
            for firstletter in self!.titleArray {
                let array : NSMutableArray = []
                for infoModel in infoArray {
                    if (firstletter as! String) == infoModel.infoOfFirstletter {
                        array.add(infoModel)
                    }
                }
                self?.itemArrays.add(array)
            }
            
            self?.collectionView?.reloadData()
            self?.tableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageMenu", for: indexPath) as! PageMenuCollectionViewCell
        
        if self.titleArray.count != 0 {
            pageMenuCell.titleLabel.text = (self.titleArray[indexPath.row] as! String)
            if defaultSelectIndex == indexPath.row {
                pageMenuCell.backgroundColor = .purple
            } else {
                pageMenuCell.backgroundColor = .clear
            }
        }

        return pageMenuCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaultSelectIndex = indexPath.row
        collectionView.reloadData()
        if indexPath.row > 2 {
            let moveIndex = indexPath.row + 1 - 3
            collectionView.setContentOffset(CGPoint(x: itemWidth * CGFloat(moveIndex), y: 0), animated: true)
        } else {
            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        tableView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.setContentOffset(CGPoint(x: itemWidth * CGFloat(defaultSelectIndex! - 1), y: 0), animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if itemWidth == 0 {
            return CGSize(width: CGFloat((WIDTH - 50) / CGFloat(self.titleArray.count)), height: 50)
        } else {
            return CGSize(width: itemWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    var unfoldBool : Bool = false
    @objc func unfoldCollectionView(sender : UIButton) {
        if itemWidth != 0 {
            let numRows = (WIDTH - 50) / itemWidth
            let numSections = CGFloat(self.titleArray.count) / numRows
            
            if unfoldBool == false {
                UIView.animate(withDuration: 0.3) {
                    self.unfoldIcon.transform = CGAffineTransform(rotationAngle: .pi)
                }
                layout.scrollDirection = .vertical
                collectionView?.snp.updateConstraints({ (ConstraintMaker) in
                    ConstraintMaker.height.equalTo(ceil(numSections) * 50)
                })
                unfoldBool = true
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.unfoldIcon.transform = CGAffineTransform(rotationAngle: 0)
                }
                layout.scrollDirection = .horizontal
                collectionView?.snp.updateConstraints({ (ConstraintMaker) in
                    ConstraintMaker.height.equalTo(50)
                })
                unfoldBool = false
            }

            collectionView?.reloadData()
        }
    }
    
    //MARK: ========================tableview==============================
    let itemArrays : NSMutableArray = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.itemArrays.count != 0 {
            let array : Array<Any> = self.itemArrays[defaultSelectIndex!] as! Array<Any>
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
        
        if self.itemArrays.count != 0 {
            let array : Array<InfoModel> = self.itemArrays[defaultSelectIndex!] as! Array<InfoModel>
            let infoModel : InfoModel = array[indexPath.row]
            listCell.listIcon.kf.setImage(with: URL(string: "https:" + infoModel.infoOfImg!))
            listCell.listName.text = infoModel.infoOfName
        }

        return listCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

class PageMenuCollectionViewCell : UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ListTableViewCell: UITableViewCell {
    
    let listIcon = UIImageView()
    let listName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        listIcon.layer.borderWidth = 0.5
        listIcon.layer.borderColor = UIColor.black.cgColor
        self.contentView.addSubview(listIcon)
        listIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.left.equalToSuperview().offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        listName.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.contentView.addSubview(listName)
        listName.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.left.equalTo(listIcon.snp.right).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
