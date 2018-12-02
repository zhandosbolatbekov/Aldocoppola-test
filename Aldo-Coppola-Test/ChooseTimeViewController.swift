//
//  ChooseTimeViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/28/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit


class ChooseTimeViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        timePicker.minimumDate = currentDate
    }
}

