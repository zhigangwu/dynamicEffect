//
//  DetailView.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/12/28.
//

import UIKit

class DetailView: UIView,UITableViewDelegate,UITableViewDataSource {

    var infoModel : InfoModel? = nil
    let iconImageView = UIImageView()
    
    let tableView = UITableView()
    var dataArray : NSMutableArray = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor  = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "detail")
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100 + 40)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func iconImageViewAnimation(infoModel : InfoModel, startFrame : CGRect) {
        iconImageView.backgroundColor = .clear
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor.black.cgColor
        iconImageView.frame = startFrame
        self.addSubview(iconImageView)
        iconImageView.kf.setImage(with: URL(string: "https:" + infoModel.infoOfImg!))
        UIView.animate(withDuration: 1) {
            self.backgroundColor  = .white
            self.iconImageView.frame = CGRect(x: (WIDTH - 40) / 2, y: 88, width: 40, height: 40)
        }
        
        requestDetail(infoModel: infoModel)
    }
    
    func requestDetail(infoModel : InfoModel) {
        PublicRequest.requestDetailData(detailid: infoModel.infoOfid!) { [weak self] model in
            self?.dataArray = []
            self?.dataArray.addObjects(from: model.successModelOfInfo)
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailTableViewCell
        
        if self.dataArray.count != 0 {
            let infoModel = self.dataArray[indexPath.row]
            detailCell.configuration(model: infoModel as! InfoModel)
        }
        
        return detailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 55
//    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class DetailTableViewCell : UITableViewCell {
    
    let icon = UIImageView()
    
    let pingyin = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon.layer.borderWidth = 0.5
        icon.layer.borderColor = UIColor.black.cgColor
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        pingyin.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        pingyin.textColor = .black
        self.contentView.addSubview(pingyin)
        pingyin.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.left.equalTo(icon.snp.right).offset(10)
        }
        
    }
    
    func configuration(model : InfoModel) {
        icon.kf.setImage(with: URL(string: model.image!))
        pingyin.text = model.chexiPingYin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
