//
//  AdvancingStyleViewController.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/12/28.
//

import UIKit

class AdvancingStyleViewController: UIViewController,NavTitleProtocol {
    
    var navTitle: String {return "AdvancingStyle"}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = navTitle
        
        
    }
}
