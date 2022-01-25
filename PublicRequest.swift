//
//  PublicRequest.swift
//  AnimationCollection
//
//  Created by Ryan on 2021/12/20.
//

import UIKit
import Alamofire
import HandyJSON

class PublicRequest: NSObject {
    
    static func requestDataList(completion : ((_ model : SuccessModel) -> (Void))? = nil) {
        let parameters : Parameters = ["type" : "brand","from" : 0,"pagesize" : 300]
        Alamofire.request("https://tool.bitefu.net/car/", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let successModel = SuccessModel.deserialize(from: response.result.value as? Dictionary)!
                print("model======",response.result.value as? Dictionary<String,Any> ?? [:])
                completion?(successModel)
                break
            case .failure(_):
                print("请求失败")
                break
            }
        }
    }
    
    static func requestDetailData(detailid : Int,completion : ((_ model : SuccessModel) -> (Void))? = nil) {
        let parameters : Parameters = ["type" : "detail","from" : 2, "id" : detailid]
        Alamofire.request("https://tool.bitefu.net/car/", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let successModel = SuccessModel.deserialize(from: response.result.value as? Dictionary)!
                print("model======",response.result.value as? Dictionary<String,Any> ?? [:])
                completion?(successModel)
                break
            case .failure(_):
                print("请求失败")
                break
            }
        }
    }

}

struct SuccessModel: HandyJSON {
    
    var successModelOfInfo : Array<InfoModel> = []
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.successModelOfInfo <-- "info"
    }
}

struct InfoModel: HandyJSON {
    
    var infoOfFirstletter : String? = ""
    var infoOfid : Int?
    var infoOfImg : String? = ""
    var infoOfName : String? = ""
    
    // detail
    var number : String? = ""
    var id : String? = ""
    var name : String? = ""
    var image : String? = ""
    var chexi : String? = ""
    var chexiName : String? = ""
    var chexiFullName : String? = ""
    var chexiPingYin : String? = ""
    var nianFen : String? = ""
    var shengChangState : String? = ""
    var xiaoShouState : String? = ""
    var club : String? = ""
    var jiBie : String? = ""
    var colors : String? = ""
        
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.infoOfFirstletter <-- "firstletter"
        mapper <<<
            self.infoOfid <-- "id"
        mapper <<<
            self.infoOfImg <-- "img"
        mapper <<<
            self.infoOfName <-- "name"
        
        mapper <<<
        self.number <-- "10"
        mapper <<<
        self.id <-- "编号"
        mapper <<<
        self.name <-- "名称"
        mapper <<<
        self.image <-- "图片"
        mapper <<<
        self.chexi <-- "车系"
        mapper <<<
        self.chexiName <-- "车系名称"
        mapper <<<
        self.chexiFullName <-- "车系全称"
        mapper <<<
        self.chexiPingYin <-- "车系拼音"
        mapper <<<
        self.nianFen <-- "年款"
        mapper <<<
        self.shengChangState <-- "生产状态"
        mapper <<<
        self.xiaoShouState <-- "销售状态"
        mapper <<<
        self.club <-- "论坛"
        mapper <<<
        self.jiBie <-- "级别"
        mapper <<<
        self.colors <-- "颜色"
    }
}
