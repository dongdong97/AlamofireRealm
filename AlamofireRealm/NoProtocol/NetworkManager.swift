//
//  NetworkManager.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let SERVER_URL = ""
    
    // singleton
    static let shared = NetworkManager()
    private init() { }
    
    func getContacts(completionHandler: @escaping ([Contact]?, String?) -> ()) {
//        Parameters
//        [String:Any]
//        HTTPHeaders
//        [String:String]
        
//        let params:[String:Any] = [
//            "sno" : "201101720"
//        ]
//
//        let header:[String:String] = [
//            "Content-Type" : "application/x-www-form-urlencoded"
//        ]
        
        
        
//        Alamofire.request(SERVER_URL, method: .get, parameters: params, headers: header).responseJSON(completionHandler: { response in
//
//        })
        
//        Alamofire.request(SERVER_URL).responseJSON(completionHandler: { response in
//
//        })
        
        
        Alamofire.request(SERVER_URL).responseJSON { response in
//            let code = response.response?.statusCode
//            print(code)

            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {
                    // JSONArray
                    completionHandler(nil, "array parsing error")
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
                
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")
            }
        }
    }
}
