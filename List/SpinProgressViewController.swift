//
//  SpinProgressViewController.swift
//  Test
//
//  Created by Ryan on 2021/6/17.
//

import UIKit

/// 通过 red 、 green 、blue 、alpha 颜色数值
public let RGBAlpa:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}



class SpinProgressViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "SpinProgress"}
    
    let bgView = UIView()
    let spinProgressView = SpinProgressView(frame: .zero)
    let cardButton = UIButton()
    
    var timer = Timer()
    var frameAnimationTimer = Timer()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        bgView.backgroundColor = .lightGray
        bgView.frame = CGRect(x: WIDTH / 2 - 42, y: HEIGHT / 2 - 42, width: 84, height: 84)
        self.view.addSubview(bgView)
        
        cardButton.frame = CGRect(x: WIDTH / 2 - 40, y: HEIGHT / 2 - 40, width: 80, height: 80)
        cardButton.layer.cornerRadius = 8
        cardButton.layer.masksToBounds = true
        cardButton.setBackgroundImage(UIImage(named: "技能"), for: .normal)
        cardButton.isUserInteractionEnabled = true
        self.view.addSubview(cardButton)
        
        spinProgressView.isHidden = true
        spinProgressView.backgroundColor = .clear
        spinProgressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        cardButton.addSubview(spinProgressView)
        
        cardButton.addTarget(self, action: #selector(clcikCardButton), for: .touchUpInside)
        
        layoutFrameAnimationImageView()
        
    }
    
    let upAnimation = UIImageView()
    let rightAnimation = UIImageView()
    let downAnimation = UIImageView()
    let leftAnimation = UIImageView()
    
    func layoutFrameAnimationImageView() {
        upAnimation.frame = CGRect(x: -10, y: 0, width: 10, height: 2)
        upAnimation.backgroundColor = .white
        bgView.addSubview(upAnimation)
        
        rightAnimation.frame = CGRect(x: 82, y: -10, width: 2, height: 10)
        rightAnimation.backgroundColor = .white
        bgView.addSubview(rightAnimation)

        downAnimation.frame = CGRect(x: 84 , y: 82 , width: 10, height: 2)
        downAnimation.backgroundColor = .white
        bgView.addSubview(downAnimation)

        leftAnimation.frame = CGRect(x: 0, y: 84, width: 2, height: 10)
        leftAnimation.backgroundColor = .white
        bgView.addSubview(leftAnimation)
    }
    
    func startFrameAnimationImageView() {
        UIView.animate(withDuration: 0.5) {
            self.upAnimation.frame = CGRect(x: 84, y: 0, width: 10, height: 2)
            self.rightAnimation.frame = CGRect(x: 82, y: 84, width: 2, height: 10)
            self.downAnimation.frame = CGRect(x: -10, y: 82, width: 10, height: 2)
            self.leftAnimation.frame = CGRect(x: 0, y: -10, width: 2, height: 10)
        } completion: { (Bool) in
            self.upAnimation.frame = CGRect(x: -10, y: 0, width: 10, height: 2)
            self.rightAnimation.frame = CGRect(x: 82, y: -10, width: 2, height: 10)
            self.downAnimation.frame = CGRect(x: 84 , y: 82 , width: 10, height: 2)
            self.leftAnimation.frame = CGRect(x: 0, y: 84, width: 2, height: 10)
        }
    }
    
    @objc func clcikCardButton() {
        self.startFrameAnimationImageView()
        
        self.spinProgressView.durationSecond = 10
        
        self.spinProgressView.setNeedsDisplay()
        self.spinProgressView.isHidden = false
        self.cardButton.isUserInteractionEnabled = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.reDrawView()
        })

        self.frameAnimationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.startFrameAnimationImageView()
        })
        

        
    }

    func reDrawView() {
        spinProgressView.setNeedsDisplay() // 重绘界面
        if spinProgressView.finishAngle > Double(spinProgressView.beginAngle) + .pi * 2 {
            timer.invalidate()
            frameAnimationTimer.invalidate()
            spinProgressView.isHidden = true
            cardButton.isUserInteractionEnabled = true
            spinProgressView.finishAngle = Double.pi * 3 / 2
        }
    }
    

    
    deinit {
        print("释放",self)
    }
}

class SpinProgressView : UIView {
    
    var beginAngle = Double.pi * 3 / 2 // 起点
    var finishAngle = Double.pi * 3 / 2
    
    var durationSecond : Double? = 0
    var _second : Double? {
        willSet {
            durationSecond = _second
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {

        let color = RGBAlpa(0,0,0,0.6)
        color.set() // 设置线条颜色
        
        let aPath = UIBezierPath(arcCenter: CGPoint(x: 40, y: 40), radius: 55, startAngle: (CGFloat)(beginAngle), endAngle: (CGFloat)(finishAngle), clockwise: false)
        aPath.addLine(to: CGPoint(x: 40, y: 40))
//        aPath.close()
        aPath.lineWidth = 1.0 // 线条宽度
        aPath.fill() // Draws line 根据坐标点连线，填充
        
        if durationSecond != 0 {
            finishAngle += 2 * Double.pi / durationSecond!  
        }
         // 更新终点
        
        print("finishAngle====",finishAngle)
    }
}


class ProgressControl: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private var _progressValue:CGFloat = 0

    public func getProgressValue()->CGFloat{
        return _progressValue
    }
    
    public func setProgressValue(value:CGFloat){
        _progressValue = value
        
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect)
//    {
//        // Drawing code
//
//        var ctx = UIGraphicsGetCurrentContext()
//
//        var r = rect.width/2
//
//        CGContextAddArc(ctx, r, r, r, 0, 3.141592653*2, 0)
//        CGContextSetRGBFillColor(ctx!, 0.7, 0.7, 0.7, 1)
//        ctx.fillPath()
//
//
//        CGContextAddArc(ctx, r, r, r, 0, 3.141592653*2*_progressValue, 0)
//        CGContextAddLineToPoint(ctx, r, r)
//        CGContextSetRGBFillColor(ctx, 0, 0, 1, 1)
//        CGContextFillPath(ctx)
//    }
}
