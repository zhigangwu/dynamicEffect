//
//  MeterLabelViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/7/28.
//

import UIKit

class MeterLabelViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "MeterLabel"}
    
    var numValue : Int = 0
    let numberLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        numberLabel.text = String(numValue)
        numberLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        self.view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        let chongzhi = UIButton()
        chongzhi.setTitle("重置", for: .normal)
        chongzhi.setTitleColor(.black, for: .normal)
        chongzhi.addTarget(self, action: #selector(clickChongzhi), for: .touchUpInside)
        self.view.addSubview(chongzhi)
        chongzhi.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalToSuperview().offset(-HEIGHT / 3)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.endOfCountdown(stopValue: 475)
        }

    }
    
    var acceleratorTimer : Timer? = nil
    
    func endOfCountdown(stopValue : Int) {
        numValue = 0
        numberLabel.text = String(numValue)
        
        if acceleratorTimer == nil {
            acceleratorTimer = Timer.scheduledTimer(withTimeInterval: 0.00168, repeats: true, block: { [weak self] (timer) in
                self?.numValue =  self!.numValue + 1
                DispatchQueue.main.async {
                    self?.numberLabel.text = String(self!.numValue)
                }
                if self!.numValue >= stopValue {
                    timer.invalidate()
                    self?.acceleratorTimer?.invalidate()
                    self?.acceleratorTimer = nil
                }
            })
        }
    }
    
    @objc func clickChongzhi() {
        endOfCountdown(stopValue: 475)
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
