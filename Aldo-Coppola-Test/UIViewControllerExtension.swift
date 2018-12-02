//
//  ViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct Constants {
    static let alertViewTintColor = UIColor.red
    static let barTintColor = UIColor.red
}

private struct Title {
    static let close = "Закрыть"
}

extension UIViewController: NVActivityIndicatorViewable {
    func showAlert(with title: String?, and message: String?, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message,
                                        preferredStyle: .alert)
        alertVC.view.tintColor = Constants.alertViewTintColor
        alertVC.addAction(UIAlertAction(title: Title.close, style: .default) { _ in
            completion?()
        })
        present(alertVC, animated: true) {
            alertVC.view.tintColor = Constants.alertViewTintColor
        }
    }
}


