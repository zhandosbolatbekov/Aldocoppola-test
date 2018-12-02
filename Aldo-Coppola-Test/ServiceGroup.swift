//
//  ServiceGroup.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import ObjectMapper
import FirebaseDatabase

struct ServiceGroup: Mappable, Codable {
    
    var name: String!
    var services: [Service]!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        services <- map["services"]
    }
    
    static func getServiceGroups(completion: (([ServiceGroup]?) -> Void)? = nil) {
        let ref = Database.database().reference()
        ref.child("service_groups").observe(.value) { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                var serviceGroups = [ServiceGroup]()
                
                for child in result {
                    _ = child.key
                    let serviceGroupJson = child.value as! NetworkService.JSON
                    let newServiceGroup = ServiceGroup(JSON: serviceGroupJson)!
                    serviceGroups.append(newServiceGroup)
                }
                
                Storage.serviceGroups = serviceGroups
                completion?(Storage.serviceGroups)
            }
        }
        completion?(nil)
    }
}
