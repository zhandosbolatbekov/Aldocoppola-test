//
//  DescriptionTableViewCell.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/26/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var descriptionText: String! {
        didSet {
            self.descriptionLabel.text = descriptionText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
