//
//  AnimationCollectionList.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/7/28.
//

import UIKit
import SnapKit

class AnimationCollectionList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var sectionArray = [""]
    var vcArray = [LotteryViewController(),SpinOf3DViewController(),SpinProgressViewController(),BubbleViewController(),MeterLabelViewController(),RollLabelViewController()]
    var titleArray = ["Lottery","SpinOf3D","SpinProgress","Bubble","MeterLabel","RollLabel"]

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
        self.navigationController?.pushViewController(vcArray[indexPath.row], animated: true)
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



