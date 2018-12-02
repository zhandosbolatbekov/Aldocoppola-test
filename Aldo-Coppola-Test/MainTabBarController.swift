//
//  MainTabBarController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoNC = Storyboard.infoNC
        infoNC.tabBarItem = UITabBarItem(title: "Информация", image: #imageLiteral(resourceName: "info-icon"), tag: 0)
    
        let entryNC = Storyboard.entryNC
        
        let profileNC = Storyboard.profileNC
        profileNC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile-icon"), tag: 2)
        
        viewControllers = [infoNC, entryNC, profileNC]
        setupMiddleButton()
        // Do any additional setup after loading the view.
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 48))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.tag = 1
        menuButton.backgroundColor = UIColor.init(red: 0.9, green: 0, blue: 0, alpha: 1.0)
        menuButton.layer.shadowOpacity = 0.5
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        menuButton.layer.shadowRadius = 10
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.cornerRadius = 15
        menuButton.setImage(#imageLiteral(resourceName: "registration-icon-white"), for: .normal)
        menuButton.addTarget(self, action: #selector(goToEntry), for: .touchUpInside)
        
        view.addSubview(menuButton)
        
        view.layoutIfNeeded()
    }
    
    @objc func goToEntry() {
        self.present(Storyboard.entryNC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
