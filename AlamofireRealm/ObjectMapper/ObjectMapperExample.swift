//
//  ObjectMapperExample.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

// 설명을 위해 extension 을 사용. 사용할 때는 기존 클래스 내부에 작성하면 됨.
// https://github.com/Hearst-DD/ObjectMapper
// https://github.com/tristanhimmelman/AlamofireObjectMapper

//pod 'ObjectMapper', '~> 3.1'
//pod 'AlamofireObjectMapper', '~> 5.0'

class Contact2:Object, Mappable {
    @objc dynamic var name:String = ""
    @objc dynamic var position:String = ""
    @objc dynamic var phone:String?
    @objc dynamic var dpart:String = ""
    @objc dynamic var part:String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name <- map["NAME"]
        self.position <- map["POSITION"]
        self.phone <- map["PHONE"]
        self.dpart <- map["DPART"]
        self.part <- map["PART"]
    }
}

extension ContactNetworkModel {
    
    func getContactWithObjectMapper() {
        // JSONArray 받아올 때
        Alamofire.request(SERVER_URL).responseArray { (response: DataResponse<[Contact2]>) in
            switch response.result {
            case .success(let item):
                self.view.networkResult(resultData: item, code: self._getContacts)
            case .failure(let error):
                print(error)
                self.view.networkFailed(code: self._getContacts)
            }
        }
    }
}
