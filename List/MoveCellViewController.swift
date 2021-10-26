//
//  MoveCellViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/9/15.
//

import UIKit

class MoveCellViewController: UIViewController,NavTitleProtocol,UITableViewDelegate,UITableViewDataSource {
    
    var navTitle: String {return "MoveCell"}

    let tableView = UITableView()
    let dataArray = ["1","2","3","4","5","6","7","8","9"]
    var moveType : String = "Progressive"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        let segmentedControl = UISegmentedControl.init(items: ["渐进","同时"])
        segmentedControl.addTarget(self, action: #selector(triggerSegmentedControl), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(100)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: WIDTH - 40, height: 28))
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MoveCellTableViewCell.self, forCellReuseIdentifier: "move")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(segmentedControl.snp.bottom).offset(20)
            ConstraintMaker.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    var indexArray : NSMutableArray = []
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moveCell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath) as! MoveCellTableViewCell
        
        moveCell.selectionStyle = .none
        moveCell.backgroundColor = .white
        moveCell.message.text = dataArray[indexPath.row]
        if moveType != "" {
            moveCell.cellMove(index: indexPath, moveType: moveType, indexArray: indexArray)
        }
        
        if selectedArray.count != 0 {
            if selectedArray[0] as! Int == indexPath.row {
                if backBoolArray.contains(selectedArray[0] as! Int) {
                    UIView.animate(withDuration: 0.5) {
                        moveCell.message.textAlignment = .right
                        moveCell.baseView.layer.transform = CATransform3DRotate(moveCell.baseView.layer.transform, CGFloat.pi , 1, 0, 0)
                        moveCell.message.layer.transform = CATransform3DRotate(moveCell.message.layer.transform, CGFloat.pi , 1, 0, 0)
                    }
                } else {
                    UIView.animate(withDuration: 0.5) {
                        moveCell.message.textAlignment = .left
                        moveCell.baseView.layer.transform = CATransform3DRotate(moveCell.baseView.layer.transform, -CGFloat.pi , 1, 0, 0)
                        moveCell.message.layer.transform = CATransform3DRotate(moveCell.message.layer.transform, -CGFloat.pi , 1, 0, 0)
                    }
                }
            }
        }

        return moveCell
    }
    
    var selectedArray : NSMutableArray = []
    var backBoolArray : NSMutableArray = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArray = []
        selectedArray.add(indexPath.row)
        if backBoolArray.contains(indexPath.row) {
            backBoolArray.remove(indexPath.row)
        } else {
            backBoolArray.add(indexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    @objc func triggerSegmentedControl(sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            moveType = "Progressive"
            break
        case 1:
            moveType = "Both"
            break
        default:
            break
        }
        indexArray = []
        tableView.reloadData()
    }
}

class MoveCellTableViewCell: UITableViewCell {
    
    let baseView = UIView()
    let message = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        baseView.frame = CGRect(x: WIDTH, y: 2, width: WIDTH - 4, height: 40)
        baseView.layer.cornerRadius = 5
        baseView.layer.masksToBounds = true
        baseView.backgroundColor = .purple
        self.contentView.addSubview(baseView)
        
        message.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        message.textColor = .white
        message.textAlignment = .left
        baseView.addSubview(message)
        message.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.left.equalToSuperview().offset(10)
            ConstraintMaker.right.equalToSuperview().offset(-10)
        }
        
    }
    
    
   
    func cellMove(index : IndexPath,moveType : String, indexArray : NSMutableArray) {
        if indexArray.contains(index.row) {
            
        } else {
            indexArray.add(index.row)
            baseView.frame = CGRect(x: WIDTH, y: 2, width: WIDTH - 4, height: 40)
            if moveType == "Progressive" {
                UIView.animate(withDuration: TimeInterval(0.5 + Float(index.row)  / 10)) {
                    self.baseView.frame = CGRect(x: 2, y: 2, width: WIDTH - 4, height: 40)
                }
            } else if moveType == "Both" {
                UIView.animate(withDuration: 0.5) {
                    self.baseView.frame = CGRect(x: 2, y: 2, width: WIDTH - 4, height: 40)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
