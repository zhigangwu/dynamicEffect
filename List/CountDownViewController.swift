//
//  CountDownViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/11/23.
//

import UIKit

class CountDownViewController: UIViewController,NavTitleProtocol,UITableViewDelegate,UITableViewDataSource,CountDownCellDelegate {
    
    var navTitle: String {return "CountDownView"}
    
    let tableView = UITableView()
    let dataArray : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountDownCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(88)
            ConstraintMaker.left.right.equalToSuperview()
            ConstraintMaker.height.equalTo(40)
        }
        
        let add = UIButton()
        add.setTitle("添加", for: .normal)
        add.setTitleColor(.black, for: .normal)
        add.addTarget(self, action: #selector(cliclAdd), for: .touchUpInside)
        self.view.addSubview(add)
        add.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.bottom.equalToSuperview().offset(-30)
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
        self.timer = nil
    }
    
    var mutableArray : NSMutableArray = []
    @objc func cliclAdd() {
        let timeInterval: TimeInterval = Date(timeIntervalSinceNow: 0).timeIntervalSince1970
        let millisecond = Double(round(timeInterval*1000))
        
        let countDownModel = CountDownModel()
        countDownModel.currentTimer = Int(millisecond)
        countDownModel.endTimer = Int(millisecond + 20)
        
        self.dataArray.add(countDownModel)
        updateMutableArray()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountDownCell
        
        if self.dataArray.count != 0 {
            if self.dataArray[indexPath.row] is String == false {
                cell.delegate = self
                let countDownModel : CountDownModel = self.dataArray[indexPath.row] as! CountDownModel
                cell.textLabel?.text = String(countDownModel.endTimer! - countDownModel.currentTimer!)
            }
        }
        
        return cell
    }
    
    var timer : Timer? = nil
    var agareeBool : Bool = false
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (Timer) in
                for i in 0..<(self?.dataArray.count)! {
                    if (self?.dataArray.count)! <= i {
                        self?.agareeBool = true
                        break
                    } else {
                        if self!.dataArray[i] is String == false {
                            let countDownModel : CountDownModel = self!.dataArray[i] as! CountDownModel
                            if countDownModel.endTimer! == countDownModel.currentTimer {
                                self?.dataArray.removeObject(at: i)
                                self?.updateMutableArray()
                            } else {
                                countDownModel.endTimer! -= 1
                            }
                        }
                    }
                }
                if self?.agareeBool == true {
                    self?.startTimer()
                }
                self?.tableView.reloadData()
            }
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    func updateMutableArray() {
        if dataArray.count == 0 {
            tableView.snp.updateConstraints { (ConstraintMaker) in
                ConstraintMaker.height.equalTo(40)
            }
        } else {
            tableView.snp.updateConstraints { (ConstraintMaker) in
                ConstraintMaker.height.equalTo(40 * dataArray.count)
            }
        }

        self.tableView.reloadData()
    }
    
    func stopTimer() {
        if timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func countDownFinish(index : Int) {
        print("index=======",index)
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

protocol CountDownCellDelegate : NSObjectProtocol {
    func countDownFinish(index : Int)
}

class CountDownCell: UITableViewCell {
    
    weak var delegate : CountDownCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    
    @objc func timerEvent() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
