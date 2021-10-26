//
//  SpinOf3DViewController.swift
//  Test
//
//  Created by Ryan on 2021/6/17.
//

import UIKit

class SpinOf3DViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "SpinOf3D"}
    
    var cardImageView = UIImageView()
    
    var lianXuAddEnergyTimer : Timer? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        let chongzhi = UIButton()
        chongzhi.setTitle("重置", for: .normal)
        chongzhi.setTitleColor(.black, for: .normal)
        chongzhi.addTarget(self, action: #selector(clickChongzhi), for: .touchUpInside)
        self.view.addSubview(chongzhi)
        chongzhi.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(100)
            ConstraintMaker.right.equalToSuperview().offset(-20)
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        layoutView()
    }
    
    func layoutView() {
        cardImageView.removeFromSuperview()
        cardImageView = UIImageView()
        cardImageView.frame = CGRect(x: 30, y: 100, width: 94, height: 112)
        cardImageView.backgroundColor = .clear
        cardImageView.layer.cornerRadius = 8
        cardImageView.layer.masksToBounds = true
        cardImageView.image = UIImage(named: "icon_exchange_laser01")
        self.view.addSubview(cardImageView)
        
        move()
    }
    
    var cardImageViewLayer : CALayer?
    
    func move() {
        let moveBasicAnimation = CABasicAnimation(keyPath: "position")
        moveBasicAnimation.duration = 5
        moveBasicAnimation.toValue = NSValue(cgPoint: CGPoint(x: WIDTH - 60, y: HEIGHT - 60))
        moveBasicAnimation.fillMode = .forwards
        moveBasicAnimation.isRemovedOnCompletion = false
        cardImageView.layer.add(moveBasicAnimation, forKey: nil)
        
        let spinBasicAnimation = CABasicAnimation(keyPath: "transform")
        spinBasicAnimation.beginTime = CACurrentMediaTime() + 0
        spinBasicAnimation.toValue = NSValue(caTransform3D: CATransform3DRotate(cardImageView.layer.transform, CGFloat.pi, 0, 1, 0))
        spinBasicAnimation.fillMode = .forwards
        spinBasicAnimation.isRemovedOnCompletion = false
        spinBasicAnimation.duration = 1
        spinBasicAnimation.repeatCount = 5
        spinBasicAnimation.autoreverses = true // 是否执行逆动画（在变化后的基础上接着执行）
        cardImageView.layer.add(spinBasicAnimation, forKey: "1")
        
        let zoomBasicAnimation = CABasicAnimation(keyPath: "bounds")
        zoomBasicAnimation.duration = 5
        zoomBasicAnimation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 94  * 0.2 , height: 112  * 0.2))
        zoomBasicAnimation.fillMode = .forwards
        zoomBasicAnimation.isRemovedOnCompletion = false
        cardImageView.layer.add(zoomBasicAnimation, forKey: nil)
    }
    
    func continuousRotation() {
        lianXuAddEnergyTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { (_) in
            UIView.animate(withDuration: 1) {
                self.cardImageView.layer.transform = CATransform3DRotate(self.cardImageView.layer.transform, CGFloat.pi, 0, 1, 0)
            }
        }
    }

    @objc func clickChongzhi() {
        layoutView()
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
