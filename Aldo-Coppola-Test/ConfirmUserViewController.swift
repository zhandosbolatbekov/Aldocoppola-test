//
//  ConfirmUserViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/28/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ConfirmUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func finishEntry(_ sender: UIButton) {
        if firstNameTextField.text?.isEmpty == false, lastNameTextField.text?.isEmpty == false {
            if let phone = phoneTextField.text, phone.isValid(regex: .phone) {
                self.showAlert(with: "Ваша заявка принята", and: "Ответ будет предоставлен в виде push-уведомления") {
                    self.present(Storyboard.mainTabBar, animated: true, completion: nil)
                }
            } else {
                self.showAlert(with: "", and: "Введите корректный номер телефона", completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        
        firstNameTextField.layer.cornerRadius = 8
        firstNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        firstNameTextField.delegate = self
        lastNameTextField.layer.cornerRadius = 8
        lastNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        lastNameTextField.delegate = self
        phoneTextField.layer.cornerRadius = 8
        phoneTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        phoneTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ConfirmUserViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        textField.layer.shadowRadius = 5
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
