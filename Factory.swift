//
//  Factory.swift
//  AnimationCollection
//
//  Created by Ryan on 2022/1/26.
//

import UIKit

protocol NavTitleProtocol {
    var navTitle : String { get }
}

class VCFactory {
    static func create(index : Int) -> NavTitleProtocol {
        switch index {
        case 0:
            return LotteryViewController()
        case 1:
            return SpinOf3DViewController()
        case 2:
            return SkillViewController()
        case 3:
            return BubbleViewController()
        case 4:
            return MeterLabelViewController()
        case 5:
            return RollLabelViewController()
        case 6:
            return ButtonStyleViewController()
        case 7:
            return MoveCellViewController()
        case 8:
            return ButtonAnimationViewController()
        case 9:
            return RewardsPopupViewController()
        case 10:
            return FoldMenuViewController()
        case 11:
            return CountDownViewController()
        case 12:
            return PageMenuViewController()
        case 13:
            return AdvancingStyleViewController()
        case 14:
            return CustomizeTabBarViewController()
        default:
            return LotteryViewController()
        }
    }
}


class ColorFactory {
    private static let HexRGBAlpha:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
        return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
    }
    
    private static let RGBAlpa:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
        return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
    }
    
    enum ColorType {
        case backgroundColor_1
        case backgroundColor_2
        case backgroundColor_3
        case backgroundColor_4
        case titleColor_1
    }
    
    static func select(type : ColorType) -> UIColor {
        switch type {
        case .backgroundColor_1:
            return HexRGBAlpha(0x77ac98,1)
        case .backgroundColor_2:
            return HexRGBAlpha(0xdea32c,1)
        case .backgroundColor_3:
            return HexRGBAlpha(0xef4136,1)
        case .backgroundColor_4:
            return HexRGBAlpha(0x009ad6,1)
        case .titleColor_1:
            return HexRGBAlpha(0xCCCCCC,1)
            
        }
    }
}


