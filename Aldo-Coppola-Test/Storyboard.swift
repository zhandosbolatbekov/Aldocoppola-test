//
//  Storyboard.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/26/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import UIKit

private struct Constants {
    static let mainStoryboardName = "Main"
    
    static let mainTabBar = "Main Tab Bar Controller"
    static let infoNavigationController = "Info Navigation Controller"
    static let entryNavigationController = "Entry Navigation Controller"
    static let profileNavigationController = "Profile Navigation Controller"
}

struct Storyboard {
    static let mainStoryboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
    
    static var mainTabBar: UITabBarController {
        return mainStoryboard.instantiateViewController(withIdentifier: Constants.mainTabBar) as! UITabBarController
    }
    static var infoNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: Constants.infoNavigationController) as! UINavigationController
    }
    static var entryNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: Constants.entryNavigationController) as! UINavigationController
    }
    static var profileNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: Constants.profileNavigationController) as! UINavigationController
    }
}
