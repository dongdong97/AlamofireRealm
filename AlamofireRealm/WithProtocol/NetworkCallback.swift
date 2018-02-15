//
//  NetworkCallback.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation

protocol NetworkCallback {
    
    // 성공. resultData : 결과값 / code : 식별자
    func networkResult(resultData:Any, code:String)
    
    // 실패. code : 식별자
    func networkFailed(code:String)
}
