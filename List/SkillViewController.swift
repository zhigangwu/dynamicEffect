//
//  SkillViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/12/15.
//

import UIKit

class SkillViewController: UIViewController,NavTitleProtocol,UICollectionViewDelegate,UICollectionViewDataSource,SkillCollectionViewCellDeleate {

    var navTitle: String {return "Skill"}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        layoutCollectionView()
        layoutAloneSkill()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stop()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disappear"), object: nil)
    }
    
    var collectionView : UICollectionView? = nil
    var iconArray : NSMutableArray = ["skill_a","skill_b","skill_c","skill_d","skill_e"]
    func layoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .darkGray
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: "Skill")
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(120)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 50 * 5, height: 50))
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.iconArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Skill", for: indexPath) as! SkillCollectionViewCell
        
        skillCell.skillIcon.image = UIImage(named: self.iconArray[indexPath.row] as! String)
        
        if selectRowArray.count != 0 {
            for i in 0..<selectRowArray.count {
                let index : Int = selectRowArray[i] as! Int
                if index == indexPath.row {
                    skillCell.delegate = self
                    skillCell.skillCooldown(row: indexPath.row)
                }
            }
        }
        
        return skillCell
    }
    
    var selectRowArray : NSMutableArray = []
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectRowArray.contains(indexPath.row) {
            
        } else {
            selectRowArray.add(indexPath.row)
            let index = IndexPath(row: indexPath.row, section: 0)
            collectionView.reloadItems(at: [index])
        }
    }
    
    func skillFinish(row : Int) {
        if selectRowArray.contains(row) {
            selectRowArray.remove(row)
        }
    }
    
    
    let bgView = UIView()
    let spinProgressView = SpinProgressView(frame: .zero)
    let cardButton = UIButton()
    func layoutAloneSkill() {
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
    
    var timer : Timer? = nil
    var alreadydurationSecond = 5
    var totaldurationSecond = 20
    
    @objc func clcikCardButton() {
        if self.timer == nil {
            self.spinProgressView.setNeedsDisplay()
            self.spinProgressView.isHidden = false
            self.cardButton.isUserInteractionEnabled = false
            
            let averageAngle : CGFloat = CGFloat.pi * 2 / CGFloat(totaldurationSecond)
            if alreadydurationSecond != 0 {
                self.spinProgressView.finishAngle = CGFloat.pi * 3 / 2 + averageAngle * CGFloat(alreadydurationSecond)
            }
            totaldurationSecond = totaldurationSecond - alreadydurationSecond
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (Timer) in
                if self!.totaldurationSecond <= 0 {
                    self?.stop()
                } else {
                    self?.startFrameAnimationImageView()
                    self!.spinProgressView.finishAngle = self!.spinProgressView.finishAngle + averageAngle
                    DispatchQueue.main.async {
                        self?.spinProgressView.setNeedsDisplay()
                    }
                }
                self!.totaldurationSecond -= 1
            })
        }
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        self.spinProgressView.isHidden = true
        self.spinProgressView.finishAngle = CGFloat.pi * 3 / 2
        self.cardButton.isUserInteractionEnabled = true
        self.totaldurationSecond = 30
    }
    
    
    deinit {
        print("释放",self)
    }
}

protocol SkillCollectionViewCellDeleate : NSObjectProtocol {
    func skillFinish(row : Int)
}

class SkillCollectionViewCell : UICollectionViewCell {
    
    weak var delegate : SkillCollectionViewCellDeleate?
    
    let rimIcon = UIImageView()
    let skillIcon = UIImageView()
    let spinProgressView = SpinProgressView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rimIcon.image = UIImage(named: "border")
        self.contentView.addSubview(rimIcon)
        rimIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(skillIcon)
        skillIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
        self.contentView.sendSubviewToBack(skillIcon)
        
        spinProgressView.isHidden = true
        spinProgressView.backgroundColor = .clear
        spinProgressView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.contentView.addSubview(spinProgressView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(stop), name: NSNotification.Name(rawValue: "disappear"), object: nil)
    }
    
    var timer : Timer? = nil
    var totaldurationSecond = 0
    
    func skillCooldown(row : Int) {
        let random = arc4random() % 40 + 1
        totaldurationSecond = Int(random)
        
        if self.timer == nil {
            self.spinProgressView.setNeedsDisplay()
            self.spinProgressView.isHidden = false
            
            let interval : TimeInterval?
            if row == 3 {
                interval = 0.1
            } else {
                interval = 1
            }

            let averageAngle : CGFloat = CGFloat.pi * 2 / CGFloat(totaldurationSecond)
            
            self.timer = Timer.scheduledTimer(withTimeInterval: interval!, repeats: true, block: { [weak self] (Timer) in
                if self!.totaldurationSecond <= 0 {
                    self?.stop()
                    self?.delegate?.skillFinish(row: row)
                } else {
                    self!.spinProgressView.finishAngle = self!.spinProgressView.finishAngle + averageAngle
                    DispatchQueue.main.async {
                        self?.spinProgressView.setNeedsDisplay()
                    }
                }
                self!.totaldurationSecond -= 1
            })
        }
    }
    
    @objc func stop() {
        self.timer?.invalidate()
        self.timer = nil
        self.spinProgressView.isHidden = true
        self.spinProgressView.finishAngle = CGFloat.pi * 3 / 2
        self.totaldurationSecond = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpinProgressView : UIView {
    
    var beginAngle = CGFloat.pi * 3 / 2 // 起点
    var finishAngle = CGFloat.pi * 3 / 2
    
    var durationSecond : Double? = 0
    var _second : Double? {
        willSet {
            durationSecond = _second
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let size = rect.size
        let arcCenter = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        let aPath = UIBezierPath(arcCenter: arcCenter, radius: 55, startAngle: beginAngle, endAngle: finishAngle, clockwise: false)
        aPath.lineWidth = 1.0 // 线条宽度
        let color = RGBAlpa(0,0,0,0.6)
        color.set() // 设置线条颜色
        aPath.addLine(to: arcCenter)
        aPath.fill() // Draws line 根据坐标点连线，填充
    }
}
