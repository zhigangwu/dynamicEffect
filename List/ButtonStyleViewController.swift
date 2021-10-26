//
//  ButtonStyleViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/9/8.
//

import UIKit

public let HexRGBAlpha:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
}

class ButtonStyleViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "ButtonStyle"}
    
    let locusButton = UIButton()
    let fillButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        locusAnimation()
        ballProgress()
        fillAnimation()

        let remove = UIButton()
        remove.setTitle("重置", for: .normal)
        remove.setTitleColor(.black, for: .normal)
        remove.addTarget(self, action: #selector(clickRemove), for: .touchUpInside)
        self.view.addSubview(remove)
        remove.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview().offset(-WIDTH / 4)
            ConstraintMaker.bottom.equalToSuperview().offset(-30)
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        let start = UIButton()
        start.setTitle("开始", for: .normal)
        start.setTitleColor(.black, for: .normal)
        start.addTarget(self, action: #selector(clickStart), for: .touchUpInside)
        self.view.addSubview(start)
        start.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview().offset(WIDTH / 4)
            ConstraintMaker.centerY.equalTo(remove)
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
    
    func locusAnimation() {
        locusButton.layer.cornerRadius = 30
        locusButton.layer.masksToBounds = true
        locusButton.layer.borderWidth = 2
        locusButton.layer.borderColor = HexRGBAlpha(0xffcc00,1).cgColor
        locusButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        self.view.addSubview(locusButton)
        locusButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.top.equalToSuperview().offset(140)
            ConstraintMaker.size.equalTo(CGSize(width: 220, height: 60))
        }
    }
    
    @objc func clickButton() {
        borderAnimation()
    }
    
    
    var bezierPath = UIBezierPath()
    let layer = CAShapeLayer.init()
    
    func borderAnimation() {
        bezierPath.removeAllPoints()
        bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: WIDTH / 2, y: 141))
        bezierPath.addLine(to: CGPoint(x: WIDTH / 2 + 80, y: 141))
        bezierPath.addArc(withCenter: CGPoint(x: locusButton.center.x + 80, y: locusButton.center.y), radius: 29, startAngle: 3 * .pi / 2, endAngle: .pi / 2, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: WIDTH / 2 - 80, y: 141 + 58))
        bezierPath.addArc(withCenter: CGPoint(x: locusButton.center.x - 80, y: locusButton.center.y), radius: 29, startAngle: .pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: WIDTH / 2 , y: 141))
        
        layer.frame = locusButton.bounds
        layer.path = bezierPath.cgPath
        layer.lineWidth = 2
        layer.strokeColor = UIColor.orange.cgColor
        layer.fillColor = UIColor.clear.cgColor

        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 0.3
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        layer.add(pathAnimation , forKey: "strokeEnd")
        
        self.view.layer.addSublayer(layer)
    }
    
    let ballView = UIView()
    func ballProgress() {
        ballView.layer.cornerRadius = 70
        ballView.layer.masksToBounds = true
        ballView.layer.borderWidth = 2
        ballView.layer.borderColor = HexRGBAlpha(0x66ff33,1).cgColor
        self.view.addSubview(ballView)
        ballView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.top.equalTo(locusButton.snp.bottom).offset(60)
            ConstraintMaker.size.equalTo(CGSize(width: 140, height: 140))
        }
    }
    
    @objc func clickStart() {
        let progressView = UIView(frame: CGRect(x: 0, y: 140, width: 140, height: 140))
        progressView.backgroundColor = HexRGBAlpha(0xcc0000,1)
        ballView.addSubview(progressView)
        
        UIView.animate(withDuration: 2) {
            progressView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        }
    }
    
    var fillLeftView = UIView()
    let fillRightView = UIView()
    func fillAnimation() {
        fillLeftView.frame = CGRect(x: (WIDTH - 10) / 2, y: 470 , width: 0, height: 60)
        fillLeftView.backgroundColor = .purple
        fillLeftView.layer.cornerRadius = 30
        fillLeftView.layer.masksToBounds = true
        self.view.addSubview(fillLeftView)
        
        fillButton.setTitle("登录", for: .normal)
        fillButton.setTitleColor(.black, for: .normal)
        fillButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        fillButton.layer.cornerRadius = 30
        fillButton.layer.masksToBounds = true
        fillButton.layer.borderWidth = 2
        fillButton.layer.borderColor = HexRGBAlpha(0xffcc00,1).cgColor
        fillButton.addTarget(self, action: #selector(clickFillButton), for: .touchUpInside)
        self.view.addSubview(fillButton)
        fillButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalTo(fillLeftView)
            ConstraintMaker.size.equalTo(CGSize(width: 220, height: 60))
        }
    }
    
    @objc func clickFillButton() {
        UIView.animate(withDuration: 0.3) { [self] in
            fillLeftView.frame = CGRect(x: fillButton.frame.origin.x, y: fillButton.frame.origin.y, width: 220, height: 60)
        }
        
    }
    
    @objc func clickRemove() {
        bezierPath.removeAllPoints()
        layer.removeFromSuperlayer()
        UIView.animate(withDuration: 0.3) {
            self.fillLeftView.frame = CGRect(x: (WIDTH - 10) / 2, y: 470 , width: 0, height: 60)
        }
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
