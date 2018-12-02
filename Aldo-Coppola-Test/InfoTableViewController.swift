//
//  InfoTableViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/26/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import FirebaseDatabase

private struct Constants {
    static let imagesCell = "ImagesTableViewCell"
    static let descriptionCell = "DescriptionTableViewCell"
    static let contactsCell = "ContactsTableViewCell"
    static let collectionViewCell = "CollectionViewCell"
}

private enum SectionType: Int {
    case images = 0
    case description = 1
    case contacts = 2
}

class InfoTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Storage.clear()
        configureTableView()
//        configureNavigationBar()
        downloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        navigationItem.rightBarButtonItem?.tintColor = UIColor.red
    }
    
    private func configureTableView() {
        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
    
    private func downloadData() {
        if Storage.info == nil {
            startAnimating()
            Info.getInfo { (info) in
                if let info = info {
                    self.stopAnimating()
                    print(info)
                    self.tableView.reloadData()
                } else {
                    print("failed downloadData")
                }
            }
        }
    }
    
    private func downloadImageUrls() {
        self.startAnimating()
        let ref = Database.database().reference()
        ref.child("images").child("info").observe(.value) { (snapshot) in
            self.stopAnimating()
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                var imageUrls = [String]()
                for child in result {
                    let url = child.value as! String
                    imageUrls.append(url)
                    print(url)
                }
                Storage.imageUrls = imageUrls
                print(Storage.imageUrls)
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func onCallButtonPressed(_ sender: UIBarButtonItem) {
        if Storage.info != nil {
            Storage.info.phone.makeAColl()
        }
    }
}

extension InfoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // images
        // description
        // contacts
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionType(rawValue: indexPath.row)! {
        case .images:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.imagesCell, for: indexPath) as! ImagesTableViewCell
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.descriptionCell, for: indexPath) as! DescriptionTableViewCell
            if Storage.info != nil {
                cell.descriptionText = Storage.info.description
            }
            return cell
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactsCell, for: indexPath) as! ContactsTableViewCell
            if Storage.info != nil {
                cell.phone = Storage.info.phone
                cell.site = Storage.info.site
                cell.callPhoneHandler = {
                    cell.phone.makeAColl()
                }
                cell.openSiteHandler = {
                    cell.site.openURL()
                }
                cell.openFbHandler = {
                    Storage.info.facebookLink.openURL()
                }
                cell.openInstagramHandler = {
                    Storage.info.instagramLink.openURL()
                }
                cell.openYoutubeHandler = {
                    Storage.info.youtubeLink.openURL()
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch SectionType(rawValue: indexPath.row)! {
        case .images:
            if let cell = cell as? ImagesTableViewCell {
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
            }
        default: return
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionType(rawValue: indexPath.row)! {
        case .images:
            return 250.0
        default:
            return UITableViewAutomaticDimension
        }
    }
}

extension InfoTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Storage.info == nil {
            return 0
        }
        return Storage.info.image_urls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as! ImagesCollectionViewCell
        if Storage.info != nil {
            cell.imageUrl = Storage.info.image_urls[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
}
