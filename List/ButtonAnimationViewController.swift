//
//  ButtonAnimationViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/9/27.
//

import UIKit

class ButtonAnimationViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "ButtonAnimation"}
    
    let menuView = UIView()
    
    let button5 = UIButton()
    
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle

        animation2()
        animation3()
        animation4()
    }

    let searchLabel = UILabel()
    let baseView =  UIView()
    
    // MARK: animation2
    func animation2() {
        baseView.frame = CGRect(x: 20, y: 140, width: 190, height: 50)
        baseView.backgroundColor = HexRGBAlpha(0x6A5ACD,1)
        baseView.layer.cornerRadius = 25
        baseView.layer.masksToBounds = true
        self.view.addSubview(baseView)
        
        button5.setTitle("＋", for: .normal)
        button5.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button5.setTitleColor(.white, for: .normal)
        button5.backgroundColor = HexRGBAlpha(0xA4D3EE,1)
        button5.layer.cornerRadius = 35 / 2
        button5.layer.masksToBounds = true
        button5.addTarget(self, action: #selector(clickButton5), for: .touchUpInside)
        baseView.addSubview(button5)
        button5.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.left.equalToSuperview().offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        button6.tag = 0
        button6.backgroundColor = HexRGBAlpha(0xFFA500,1)
        button6.layer.cornerRadius = 35 / 2
        button6.layer.masksToBounds = true
        baseView.addSubview(button6)
        button6.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(button5)
            ConstraintMaker.top.equalTo(button5.snp.bottom).offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 35, height: 35))
        }

        button7.tag = 1
        button7.backgroundColor = HexRGBAlpha(0xFF3E96,1)
        button7.layer.cornerRadius = 35 / 2
        button7.layer.masksToBounds = true
        baseView.addSubview(button7)
        button7.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(button5)
            ConstraintMaker.top.equalTo(button6.snp.bottom).offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        button8.tag = 2
        button8.backgroundColor = HexRGBAlpha(0xFF3E96,1)
        button8.layer.cornerRadius = 35 / 2
        button8.layer.masksToBounds = true
        baseView.addSubview(button8)
        button8.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(button5)
            ConstraintMaker.top.equalTo(button7.snp.bottom).offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        searchLabel.text = "search"
        searchLabel.textAlignment = .center
        searchLabel.textColor = HexRGBAlpha(0x6A5ACD,1)
        searchLabel.layer.cornerRadius = 35 / 2
        searchLabel.layer.masksToBounds = true
        searchLabel.layer.borderWidth = 0.5
        searchLabel.layer.borderColor = HexRGBAlpha(0xBCD2EE,1).cgColor
        searchLabel.backgroundColor = HexRGBAlpha(0xBCD2EE,1)
        baseView.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.left.equalTo(button5.snp.right).offset(10)
            ConstraintMaker.size.equalTo(CGSize(width: 125, height: 35))
        }
        
    }

    @objc func clickButton5(sender : UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.3) {
                sender.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
                self.searchLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3 / 2)
            }
            
            searchMotionTrail(clockwise: true, sender: sender)
            buttonMotionTrail(clockwise: true, sender: sender, button: button6)
            buttonMotionTrail(clockwise: true, sender: sender, button: button7)
            buttonMotionTrail(clockwise: true, sender: sender, button: button8)
            
        } else {
            UIView.animate(withDuration: 0.3) {
                sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
                self.searchLabel.transform = CGAffineTransform(rotationAngle: 0)
            }
            
            searchMotionTrail(clockwise: false, sender: sender)
            buttonMotionTrail(clockwise: false, sender: sender, button: button6)
            buttonMotionTrail(clockwise: false, sender: sender, button: button7)
            buttonMotionTrail(clockwise: false, sender: sender, button: button8)
        }
    }
    
    func searchMotionTrail(clockwise : Bool, sender : UIButton) {
        let searchTransform = CGAffineTransform(translationX: 0, y: 0)
        let searchPath =  CGMutablePath()
        
        if clockwise == true {
            searchPath.addArc(center: CGPoint(x:sender.center.x ,y:sender.center.y), radius: 90, startAngle: 0,
                        endAngle: .pi * 3 / 2, clockwise: clockwise, transform: searchTransform)
        } else {
            searchPath.addArc(center: CGPoint(x:sender.center.x ,y:sender.center.y), radius: 90, startAngle: .pi * 3 / 2,
                        endAngle: 0, clockwise: clockwise, transform: searchTransform)
        }
        
        let animation = CAKeyframeAnimation(keyPath:"position")
        animation.duration = 0.3
        animation.path = searchPath
        animation.calculationMode = CAAnimationCalculationMode.paced
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        searchLabel.layer.add(animation,forKey:"Move")
    }
    
    func buttonMotionTrail(clockwise : Bool, sender : UIButton, button : UIButton) {
        let searchTransform = CGAffineTransform(translationX: 0, y: 0)
        let searchPath =  CGMutablePath()
        
        let spacing : Float = Float((35 + 10) * button.tag + 35 / 2)
        let radiusFloat : CGFloat = CGFloat(35 / 2 + 10 + spacing)
        
        if clockwise == true {
            searchPath.addArc(center: CGPoint(x:sender.center.x ,y:sender.center.y), radius: radiusFloat , startAngle: .pi / 2,
                        endAngle: 0, clockwise: clockwise, transform: searchTransform)
        } else {
            searchPath.addArc(center: CGPoint(x:sender.center.x ,y:sender.center.y), radius: radiusFloat , startAngle: 0,
                        endAngle: .pi / 2, clockwise: clockwise, transform: searchTransform)
        }
        
        let animation = CAKeyframeAnimation(keyPath:"position")
        animation.duration = 0.3
        animation.path = searchPath
        animation.calculationMode = CAAnimationCalculationMode.paced
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        button.layer.add(animation,forKey:"Move")
    }
    
    @objc func clickRemove() {

    }
    
    // MARK: animation3
    func animation3() {
        let follow = UIButton(frame: CGRect(x: 20, y: 220, width: 120, height: 40))
        follow.layer.cornerRadius = 20
        follow.layer.masksToBounds = true
        follow.layer.borderWidth = 1
        follow.layer.borderColor = HexRGBAlpha(0xFF3E96,1).cgColor
        follow.setTitle("follow", for: .normal)
        follow.setTitleColor(HexRGBAlpha(0xFF3E96,1), for: .normal)
        follow.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        follow.addTarget(self, action: #selector(clickFollow), for: .touchUpInside)
        self.view.addSubview(follow)
    }
    
    @objc func clickFollow(sender : UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = HexRGBAlpha(0xFF3E96,1)
        } completion: { (Bool) in
            UIView.animate(withDuration: 0.3) {
                sender.frame = CGRect(x: 100, y: 220, width: 40, height: 40)
            } completion: { (Bool) in
                sender.setImage(UIImage(named: "dwj_login_account_icon"), for: .normal)
                sender.setTitle("", for: .normal)
            }
        }
    }
    
    // MARK: animation4
    func animation4() {
        let FKButton = UIButton(frame: CGRect(x: 40, y: 300, width: 80, height: 80))
        FKButton.layer.cornerRadius = 10
        FKButton.layer.masksToBounds = true
        FKButton.backgroundColor = HexRGBAlpha(0x0066ff,1)
        FKButton.setImage(UIImage(named: "dwj_black_close_btn"), for: .normal)
        FKButton.addTarget(self, action: #selector(clickFKButton), for: .touchUpInside)
        self.view.addSubview(FKButton)
    }
    
    @objc func clickFKButton(sender : UIButton) {
        UIView.animate(withDuration: 0.5) {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        }
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
