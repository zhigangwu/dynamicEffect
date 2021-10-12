//
//  RewardsPopupViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/9/30.
//

import UIKit

class RewardsPopupViewController: UIViewController {
    
    let imageView = UIImageView()
    let imageViewCopy = UIImageView()
    let rewardImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        imageView.image = UIImage(named: "img_award_pop_top")
        imageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.centerY.equalToSuperview().offset(-80)
            ConstraintMaker.size.equalTo(CGSize(width: 1285 / 2, height: 220 / 2))
        }
        
        imageViewCopy.image = UIImage(named: "img_award_pop_top")
        imageViewCopy.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.addSubview(imageViewCopy)
        imageViewCopy.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.centerY.equalToSuperview().offset(-80)
            ConstraintMaker.size.equalTo(CGSize(width: 1285 / 2, height: 220 / 2))
        }
        
        rewardImageView.image = UIImage(named: "img_award_pop_bottom")
        self.view.addSubview(rewardImageView)
        self.view.sendSubviewToBack(rewardImageView)
        rewardImageView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(imageView.snp.bottom).offset(-15)
            ConstraintMaker.centerX.equalToSuperview().offset(-WIDTH * 2)
            ConstraintMaker.size.equalTo(CGSize(width: 1334 / 2, height: 324 / 2))
        }
        
        
        
        let remove = UIButton()
        remove.setTitle("重置", for: .normal)
        remove.setTitleColor(.black, for: .normal)
        remove.addTarget(self, action: #selector(clickRemove), for: .touchUpInside)
        self.view.addSubview(remove)
        remove.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.bottom.equalToSuperview().offset(-30)
            ConstraintMaker.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        self.animation()
    }
    
    func animation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.imageViewCopy.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.imageViewCopy.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                self.rewardImageView.center = CGPoint(x: WIDTH / 2, y: self.imageView.center.y + 55 + 81 - 15)
                
            } completion: { (Bool) in
                self.imageViewCopy.alpha = 1
                UIView.animate(withDuration: 0.8) {
                    self.imageViewCopy.alpha = 0
                    self.imageViewCopy.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                } completion: { (Bool) in
                    
                }
            }
        }

    }
    
    @objc func clickRemove() {
        self.imageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.rewardImageView.center = CGPoint(x: -WIDTH * 2 , y: self.imageView.center.y + 55 + 81 - 15)
        animation()
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
