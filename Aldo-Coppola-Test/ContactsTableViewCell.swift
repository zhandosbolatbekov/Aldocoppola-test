//
//  ContactsTableViewCell.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/27/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var siteLabel: UILabel!
    
    var phone: String! {
        didSet {
            phoneLabel.text = phone
        }
    }
    var site: String! {
        didSet {
            siteLabel.text = site
        }
    }
    
    var callPhoneHandler: (() -> Void)?
    var openSiteHandler: (() -> Void)?
    var openFbHandler: (() -> Void)?
    var openInstagramHandler: (() -> Void)?
    var openYoutubeHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(onPhoneLabelTouched))
        phoneLabel.addGestureRecognizer(phoneTap)
        
        let siteTap = UITapGestureRecognizer(target: self, action: #selector(onSiteLabelTouched))
        siteLabel.addGestureRecognizer(siteTap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onPhoneLabelTouched() {
        callPhoneHandler?()
    }
    @objc func onSiteLabelTouched() {
        openSiteHandler?()
    }
    @IBAction func onFbButtonPressed(_ sender: UIButton) {
        openFbHandler?()
    }
    @IBAction func onInstagramButtonPressed(_ sender: UIButton) {
        openInstagramHandler?()
    }
    @IBAction func onYoutubeButtonPressed(_ sender: UIButton) {
        openYoutubeHandler?()
    }
}
