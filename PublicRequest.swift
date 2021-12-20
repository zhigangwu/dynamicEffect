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
        let parameters : Parameters = ["type" : "brand","pagesize" : 300]
        Alamofire.request("https://tool.bitefu.net/car/", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                print("====",response.result.value)
                let successModel = SuccessModel.deserialize(from: response.result.value as? Dictionary)!
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
        
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.infoOfFirstletter <-- "firstletter"
        mapper <<<
            self.infoOfid <-- "id"
        mapper <<<
            self.infoOfImg <-- "img"
        mapper <<<
            self.infoOfName <-- "name"
    }
}
