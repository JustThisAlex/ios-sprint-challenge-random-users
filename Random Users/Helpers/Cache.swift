//
//  Cache.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class Cache<Item> {
    
    // MARK: - Properties
    private var cache = [Int:Item]()
    private let queue = DispatchQueue(label: "Cache")
    
    // MARK: - Methods
    func addItem(_ item: Item, for i: Int) {
        queue.async {
            self.cache.updateValue(item, forKey: i)
        }
    }
    
    func getItem(for i: Int) -> Item? {
        queue.sync {
            return cache[i]
        }
    }
    
    func exists(_ i: Int) -> Bool {
        queue.sync {
            return cache[i] == nil ? false : true
        }
    }
}
