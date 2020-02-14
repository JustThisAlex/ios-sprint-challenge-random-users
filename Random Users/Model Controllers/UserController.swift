//
//  UserController.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class UserController {
    
    // MARK: - Properties
    static let shared = UserController()
    var baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")!
    var users = [User]()
    
    // MARK: - Methods
    func get(completion: @escaping (Error?) -> ()) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error { completion(error) }
            guard let data = data else { completion(NSError(domain: "com.LambdaSchool.RandomUsers", code: 204, userInfo: nil)); return}
            
            do { self.users = try JSONDecoder().decode(Users.self, from: data).results; completion(nil) }
            catch { completion(error); return }
        }.resume()
    }
}
