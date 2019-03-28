//
//  Order.swift
//  Restaurant
//
//  Created by Ousmane Ouedraogo on 3/21/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import Foundation
struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
