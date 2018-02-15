//
//  DBManager.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    static let shared = DBManager()
    
    private init() { }
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print("Could not access Realm")
            return nil
        }
    }
    
    func saveContact(name: String, position: String, phone: String? = nil, dpart: String, part: String) {
        
        let obj = Contact()
        obj.name = name
        obj.position = position
        obj.phone = phone
        obj.dpart = dpart
        obj.part = part
        
        try! realm?.write {
            realm?.add([obj])
        }
    }
    
    func saveContact(array:[Contact]) {
        try! realm?.write {
            realm?.add(array)
        }
    }
    
    func saveContact(array:[Contact2]) {
        try! realm?.write {
            realm?.add(array)
        }
    }
    
    func getContact() -> [Contact] {
        if let objects = realm?.objects(Contact.self) {
            return Array(objects)
        }
        return []
    }
    
    func getPhone(name: String) -> String? {
        if let phone = realm?.objects(Contact.self).filter("name == %@", name).first?.phone {
            return phone
        }
        
        return nil
    }
    
    func deleteAll(){
        try! realm?.write {
            realm?.deleteAll()
        }
    }
    
}
