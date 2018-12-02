//
//  MasterTableViewCell.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/28/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var masterFirstNameLabel: UILabel!
    @IBOutlet weak var masterLastNameLabel: UILabel!
    @IBOutlet weak var masterImageView: UIImageView!
    
    var master: Master! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        masterFirstNameLabel.text = master.firstName
        masterLastNameLabel.text = master.lastName
        ImageManager.fetch(from: master.avatarUrl) { (image, url) in
            if url == self.master.avatarUrl {
                self.masterImageView.image = image
            } else {
                self.masterImageView.image = #imageLiteral(resourceName: "default-image")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        masterImageView.layer.cornerRadius = masterImageView.layer.frame.width / 2
        masterImageView.layer.shadowOpacity = 0.5
        masterImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        masterImageView.layer.shadowRadius = 10
        masterImageView.layer.shadowColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
