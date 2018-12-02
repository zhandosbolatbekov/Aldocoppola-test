//
//  Master.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/27/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import ObjectMapper
import FirebaseDatabase

struct Master: Mappable, Codable {
    
    var firstName: String!
    var lastName: String!
    var avatarUrl: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        avatarUrl <- map["avatar"]
    }
    
    static func getMasters(completion: (([Master]?) -> Void)? = nil) {
        let ref = Database.database().reference()
        ref.child("masters").observe(.value) { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                var masters = [Master]()
                for child in result {
                    let masterJson = child.value as! NetworkService.JSON
                    let master = Master(JSON: masterJson)!
                    masters.append(master)
                }
                Storage.masters = masters
                completion?(masters)
            }
        }
        completion?(nil)
    }
}
