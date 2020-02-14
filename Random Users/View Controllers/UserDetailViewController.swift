//
//  UserDetailViewController.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: - Properties
    var name: String?
    var imageURL: URL?
    var mail: String?
    var index: Int?
    var phone: String?
    var imgCache: Cache<Data>!
    var session: URLSessionDataTask?
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fill()
    }
    
    // MARK: - Methods
    func fill() {
        guard let name = name, let mail = mail, let phone = phone, let imageURL = imageURL, let index = index else { return }
        nameLabel.text = name
        mailLabel.text = mail
        phoneLabel.text = phone
        if imgCache.exists(index) { imageView?.image = UIImage(data: imgCache.getItem(for: index)!) }
        else {
            session = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, _, error) in
                if let error = error { NSLog("\(error)") }
                guard let data = data else { NSLog("\(NSError(domain: "com.LambdaSchool.RandomUsers", code: 204, userInfo: nil))"); return}
                DispatchQueue.main.async {
                    self.imgCache.addItem(data, for: index)
                    self.imageView?.image = UIImage(data: data)
                }
            })
            session?.resume()
        }
        
    }
    
}
