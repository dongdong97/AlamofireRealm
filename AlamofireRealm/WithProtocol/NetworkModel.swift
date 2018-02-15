//
//  NetworkModel.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation
import Alamofire

class NetworkModel {
    
    // 베이스 네트워크 모델. 이를 상속해서 여러가지 네트워크 모델을 만들면 됨.
    
    // 연결된 뷰 컨트롤러
    var view: NetworkCallback
    let SERVER_URL = ""
    
    // 뷰 컨트롤러 연결
    init(_ vc: NetworkCallback){
        self.view = vc
    }
}

class ContactNetworkModel: NetworkModel {
    
    // 이렇게 네트워크 모델을 용도마다 다르게 커스터마이징해서 사용해도 됨.
    
    let _getContacts = "getcontacts"
    
    func getContacts() {
        Alamofire.request(SERVER_URL).responseJSON { response in
            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {
                    // JSONArray
                    self.view.networkFailed(code: self._getContacts)
                    return
                }
                
                var result:[Contact] = []
                
                for object in array {
                    let obj = Contact()
                    if let object = object as? NSDictionary,
                        // JSONObject
                        let name = object["NAME"] as? String,
                        let part = object["PART"] as? String,
                        let position = object["POSITION"] as? String,
                        let dpart = object["DPART"] as? String {
                        obj.name = name
                        if let phone = object["PHONE"] as? String {
                            obj.phone = phone
                        }
                        obj.part = part
                        obj.position = position
                        obj.dpart = dpart
                    }
                    result.append(obj)
                }
                self.view.networkResult(resultData: result, code: self._getContacts)
            case .failure(let error):
                print(error)
                self.view.networkFailed(code: self._getContacts)
            }
        }
    }
}
