//
//  LotteryViewController.swift
//  Test
//
//  Created by Ryan on 2021/6/4.
//

import UIKit

class LotteryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView : UICollectionView? = nil
    var win : Array<Int> = [3,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let layout = ProfileCustomLayout()
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .darkGray
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(LotteryCollectionViewCell.self, forCellWithReuseIdentifier: "Lottery")
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.center.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width: 360 + 10, height: 220 + 12))
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1  {
            return 3
        } else if section == 2 {
            return 4
        } else if section == 3 {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lotteryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Lottery", for: indexPath) as! LotteryCollectionViewCell
        
        if selectItem.count != 0 {
            let array : Array<Int> = selectItem[0] as! Array<Int>
            if array[0] == indexPath.section {
                if array[1] == indexPath.row {
                    lotteryCell.icon.layer.borderWidth = 1
                    lotteryCell.icon.layer.borderColor = UIColor.red.cgColor
                } else {
                    lotteryCell.icon.layer.borderWidth = 1
                    lotteryCell.icon.layer.borderColor = UIColor.clear.cgColor
                }
            } else {
                lotteryCell.icon.layer.borderWidth = 1
                lotteryCell.icon.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        return lotteryCell
    }
     
    let selectItem : NSMutableArray = []
    var timer : Timer? = nil
    var num : Int = -1
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let spin = [[0,0],[0,1],[0,2],[0,3],[1,2],[2,3],[3,3],[3,2],[3,1],[3,0],[2,0],[1,0]]
        if indexPath.section == 2 && indexPath.row == 1 {
            print("开始抽奖")
            selectItem.add(spin[0])
            slowRotation(array: spin)
        } else if indexPath.section == 2 && indexPath.row == 2 {
            
        }
    }
    
    func slowRotation(array : Array<Any>) {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { [weak self] (Timer) in
                self!.num = self!.num + 1
                if self!.num > 11 {
                    self!.num = 0
                }
                self?.selectItem.replaceObject(at: 0, with: array[self!.num])
                self?.collectionView?.reloadData()
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.timer?.invalidate()
                self.timer = nil
                self.qulickRotation(array: array)
            }
        }
    }
    
    func qulickRotation(array : Array<Any>) {
        self.timer?.invalidate()
        self.timer = nil
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true, block: { [weak self] (Timer) in
                self!.num = self!.num + 1
                if self!.num > 11 {
                    self!.num = 0
                }
                self?.selectItem.replaceObject(at: 0, with: array[self!.num])
                self?.collectionView?.reloadData()
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            Timer.initialize()
            self.timer?.invalidate()
            self.timer = nil
            self.startRotation(array: array)
        }
    }
    
    func startRotation(array : Array<Any>) {
        self.timer?.invalidate()
        self.timer = nil
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { [weak self] (Timer) in
                self!.num = self!.num + 1
                if self!.num > 11 {
                    self!.num = 0
                }
                self?.selectItem.replaceObject(at: 0, with: array[self!.num])
                self?.collectionView?.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let selectArray : Array<Int> = self?.selectItem[0] as! Array<Int>
                    if selectArray == self?.win {
                        print("相同")
                        self?.timer?.invalidate()
                        self?.timer = nil
                    } else {
                        print("不相同")
                    }
                }
            })
        }
    }
    
    deinit {
        print("释放",self)
    }
}

class LotteryCollectionViewCell: UICollectionViewCell {
    let icon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        icon.layer.cornerRadius = 5
        icon.layer.masksToBounds = true
        icon.backgroundColor = .lightGray
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProfileCustomLayout : UICollectionViewLayout {
// 定义collectionView的内容大小 ContentSize
    func collectionViewContentSize() -> CGSize {
        return CGSize(width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height)
    }
    
// 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)-> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        //循环遍历 section
        for j in 0..<4 {
        //获得section里面的元素个数
            let cellCount = self.collectionView!.numberOfItems(inSection: j)
        //循环给每个section里面的元素 定义属性
            for i in 0..<cellCount {
                let indexPath = IndexPath(item:i, section:j)
                let attributes = self.layoutAttributesForItemAtIndexPath(indexPath: indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
// 这个方法返回每个单元格的位置和大小
    func layoutAttributesForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//当前单元格布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith:indexPath as IndexPath)
//定义单元格frame属性
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                attribute.frame = CGRect(x: 2, y: 2, width: 90, height: 55)
            } else if indexPath.row == 1 {
                attribute.frame = CGRect(x: 94, y: 2, width: 90, height: 55)
            } else if indexPath.row == 2 {
                attribute.frame = CGRect(x: 186, y: 2, width: 90, height: 55)
            } else if indexPath.row == 3 {
                attribute.frame = CGRect(x: 278, y: 2, width: 90, height: 55)
            }
            return attribute
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                attribute.frame = CGRect(x: 2, y: 59, width: 90, height: 56)
            } else if indexPath.row == 1 {
                attribute.frame = CGRect(x: 94, y: 59, width: 182, height: 77)
            } else if indexPath.row == 2 {
                attribute.frame = CGRect(x: 278, y: 59, width: 90, height: 56)
            }
            return attribute
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                attribute.frame = CGRect(x: 2, y: 117, width: 90, height: 56)
            } else if indexPath.row == 1 {
                attribute.frame = CGRect(x: 94, y: 138, width: 90, height: 35)
            } else if indexPath.row == 2 {
                attribute.frame = CGRect(x: 186, y: 138, width: 90, height: 35)
            } else if indexPath.row == 3 {
                attribute.frame = CGRect(x: 278, y: 117, width: 90, height: 56)
            }
            return attribute
        } else {
            if indexPath.row == 0 {
                attribute.frame = CGRect(x: 2, y: 175, width: 90, height: 55)
            } else if indexPath.row == 1 {
                attribute.frame = CGRect(x: 94, y: 175, width: 90, height: 55)
            } else if indexPath.row == 2 {
                attribute.frame = CGRect(x: 186, y: 175, width: 90, height: 55)
            } else if indexPath.row == 3 {
                attribute.frame = CGRect(x: 278, y: 175, width: 90, height: 55)
            }
            return attribute
        }
    }
}

