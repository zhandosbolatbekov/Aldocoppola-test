//
//  ImagesCollectionViewCell.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/26/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var myImageView: UIImageView!
    
    var imageUrl: String! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        ImageManager.fetch(from: imageUrl) { (image, url) in
            if url == self.imageUrl {
                self.myImageView.image = image
            } else {
                self.myImageView.image = #imageLiteral(resourceName: "default-image")
            }
        }
    }
}
