//
//  UserTableViewCell.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

     var thCache: Cache<Data>!
        var index: Int! { didSet { getImage(index: index)}}
        var thumbnail: URL!
        var session: URLSessionDataTask?
        var parent: UserTableViewController?
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func getImage(index: Int) {
            if thCache.exists(index) { imageView?.image = UIImage(data: thCache.getItem(for: index)!) }
            else {
                session = URLSession.shared.dataTask(with: thumbnail, completionHandler: { (data, _, error) in
                    if let error = error { NSLog("\(error)") }
                    guard let data = data else { NSLog("\(NSError(domain: "com.LambdaSchool.RandomUsers", code: 204, userInfo: nil))"); return}
                    DispatchQueue.main.async {
                        self.thCache.addItem(data, for: index)
                        self.imageView?.image = UIImage(data: data)
                        self.parent?.tableView.reloadData()
                    }
                })
                session?.resume()
            }
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            session?.cancel()
        }
        
    }
