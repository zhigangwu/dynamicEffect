//
//  MoveCellViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/9/15.
//

import UIKit

class MoveCellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let tableView = UITableView()
    let dataArray = ["1","2","3","4"]
    var moveType : String = "Progressive"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let segmentedControl = UISegmentedControl.init(items: ["渐进","一起"])
        segmentedControl.addTarget(self, action: #selector(triggerSegmentedControl), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(100)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: WIDTH - 40, height: 28))
        }
        
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moveCell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath) as! MoveCellTableViewCell
        
        moveCell.backgroundColor = .white
        if moveType != "" {
            moveCell.cellMove(index: indexPath, moveType: moveType)
        }
        
        
        return moveCell
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
        tableView.reloadData()
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

class MoveCellTableViewCell: UITableViewCell {
    
    let baseView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        baseView.frame = CGRect(x: WIDTH, y: 2, width: WIDTH - 4, height: 40)
        baseView.layer.cornerRadius = 5
        baseView.layer.masksToBounds = true
        baseView.backgroundColor = .purple
        self.contentView.addSubview(baseView)
        
    }
    
    func cellMove(index : IndexPath,moveType : String) {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
