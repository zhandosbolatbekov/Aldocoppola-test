//
//  NetworkService.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct NetworkService {
    typealias JSON = [String: Any]
    
    static func downloadImage(from url: String,
                              completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success(let image): completion(image)
            case .failure(let error):
                completion(nil)
                print("\(url): - \(error.localizedDescription)")
            }
        }
    }
}
