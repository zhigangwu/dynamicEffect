//
//  BubbleViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/7/28.
//

import UIKit

class BubbleViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "Bubble"}
    
    let bubble = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        bubble.frame = CGRect(x: WIDTH / 2 - 42, y: HEIGHT / 2 - 42, width: 84, height: 84)
        bubble.image = UIImage(named: "lys_dragon_icon01")
        self.view.addSubview(bubble)
        
        driftAnimation()
    }
    
    var continuedBool : Bool = false
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.continuedBool = true
    }
    
    func driftAnimation() {
        if continuedBool == false {
            UIView.animate(withDuration: 0.8) {
                self.bubble.frame = CGRect(x: WIDTH / 2 - 42, y: HEIGHT / 2 - 42 - 10, width: 84, height: 84)
            } completion: { (Bool) in
                UIView.animate(withDuration: 0.8) {
                    self.bubble.frame = CGRect(x: WIDTH / 2 - 42, y: HEIGHT / 2 - 42 + 10, width: 84, height: 84)
                } completion: { (Bool) in
                    self.driftAnimation()
                }
            }
        }
    }
    
    deinit {
        bubble.layer.removeAllAnimations()
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
