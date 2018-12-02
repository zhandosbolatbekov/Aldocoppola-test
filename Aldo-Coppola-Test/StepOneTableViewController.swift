//
//  StepOneTableViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/27/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

private struct Constants {
    static let stepOneCell = "Step One Cell"
    static let chooseServiceSegue = "Choose Service"
}

class StepOneTableViewController: UITableViewController {

    @IBAction func onCloseButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        downloadData()
    }
    
    private func downloadData() {
        self.startAnimating()
        ServiceGroup.getServiceGroups { (serviceGroups) in
            self.stopAnimating()
            self.tableView.reloadData()
            print(serviceGroups)
        }
    }
    
    private func configureTableView() {
//        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
}
extension StepOneTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.serviceGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stepOneCell, for: indexPath)
        cell.textLabel?.text = Storage.serviceGroups[indexPath.row].name
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.chooseServiceSegue, sender: indexPath.row)
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.chooseServiceSegue:
            let serviceGroupIndex = sender as! Int
            let dest = segue.destination as! ChooseServiceTableViewController
            dest.services = Storage.serviceGroups[serviceGroupIndex].services
            return
        default:
            return
        }
    }

}
