//
//  Info.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/27/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import ObjectMapper
import FirebaseDatabase

struct Info: Mappable, Codable {
    var description = ""
    var email = ""
    var phone = ""
    var site = ""
    var facebookLink = ""
    var instagramLink = ""
    var youtubeLink = ""
    var image_urls = [String]()

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        description <- map["description"]
        email <- map["email"]
        phone <- map["phone_number"]
        site <- map["site"]
        image_urls <- map["images"]
        facebookLink <- map["facebook"]
        instagramLink <- map["instagram"]
        youtubeLink <- map["youtube"]
    }
        
    static func getInfo(completion: ((Info?) -> Void)? = nil) {
        let ref = Database.database().reference()
        ref.child("info").observe(.value) { (snapshot) in
            let json = snapshot.value as! NetworkService.JSON
            Storage.info = Info(JSON: json)!
            completion?(Storage.info!)
        }
        completion?(nil)
    }
}
