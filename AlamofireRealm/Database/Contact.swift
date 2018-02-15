//
//  Contact.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    //    "NAME": "송원용",
    //    "POSITION": "인문학연구소장",
    //    "PHONE": "032-835-8115",
    //    "DPART": "국어국문학과",
    //    "PART": "인문대학"
    
    @objc dynamic var name:String = ""
    @objc dynamic var position:String = ""
    @objc dynamic var phone:String?
    @objc dynamic var dpart:String = ""
    @objc dynamic var part:String = ""
    
    //    override static func primaryKey() -> String? {
    //        return "name"
    //    }
}

