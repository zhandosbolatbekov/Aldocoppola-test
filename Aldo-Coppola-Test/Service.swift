//
//  Service.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Service: Mappable, Codable {
    var id: Int!
    var name: String!
    var price: Int?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        price <- map["price"]
    }
}
