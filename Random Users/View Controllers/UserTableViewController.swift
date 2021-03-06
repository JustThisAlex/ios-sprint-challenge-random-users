//
//  UserTableViewController.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: - Properties
    let userController = UserController.shared
    var users = [User]()
    let thCache = Cache<Data>()
    let imgCache = Cache<Data>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    // MARK: - Methods
    func reloadData() {
        userController.get { (error) in DispatchQueue.main.async {
            if let error = error { print(error) }
            else { self.users = self.userController.users; self.tableView.reloadData() }
            } }
    }
    
    // MARK: - IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 { userController.lnFirst = false }
        else { userController.lnFirst = true }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.textLabel?.text = userController.lnFirst ? "\(user.title) \(user.lastName), \(user.firstName)" : "\(user.title) \(user.firstName) \(user.lastName)"
        cell.thCache = thCache
        cell.thumbnail = user.thumbnail
        cell.parent = self
        cell.index = indexPath.row
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue",  let index = tableView.indexPathForSelectedRow?.row {
            let destination = segue.destination as! UserDetailViewController
            let user = users[index]
            destination.name = userController.lnFirst ? "\(user.title) \(user.lastName), \(user.firstName)" : "\(user.title) \(user.firstName) \(user.lastName)"
            destination.imageURL = user.image
            destination.mail = user.email
            destination.imgCache = imgCache
            destination.index = index
            destination.phone = user.phone
        }
    }
    
}
