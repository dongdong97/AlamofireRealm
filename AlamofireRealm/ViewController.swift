//
//  ViewController.swift
//  AlamofireRealm
//
//  Created by SeonIl Kim on 2018. 2. 14..
//  Copyright © 2018년 Seonift. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var model:ContactNetworkModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBManager.shared.deleteAll()
        
        // realm 파일 주소
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // NO Protocol
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {
                // 에러가 있는 경우
                print(error)
            }
            if let contacts = contacts {
//                print(contacts)
                DBManager.shared.saveContact(array: contacts)
//                DispatchQueue.main.async {
//                    // UI 작업
//                    self.tableView.reloadData()
//                }
            }
        }
        
        // With Protocol
        model = ContactNetworkModel(self)
        model?.getContacts()
        
        // With ObjectMapper
//        model?.getContactWithObjectMapper()
    }
}

extension ViewController: NetworkCallback {
    // With Protocol
    
    func networkResult(resultData: Any, code: String) {
        if code == model?._getContacts {
            if let contacts = resultData as? [Contact] {
                print(contacts)
                DBManager.shared.saveContact(array: contacts)
//                // UI 작업
//                self.tableView.reloadData()
            }
            
            if let contacts = resultData as? [Contact2] {
                // ObjectMapper 사용 시
                print(contacts)
                DBManager.shared.saveContact(array: contacts)
            }
        }
    }
    
    func networkFailed(code: String) {
        if code == model?._getContacts {
            print("전화번호부 다운로드 실패")
        }
    }
}

