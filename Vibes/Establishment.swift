//
//  Establishment.swift
//  Vibes
//
//  Created by Benjamin Katz on 2/14/17.
//  Copyright © 2017 Benjamin Katz. All rights reserved.
//

import Foundation


class Establishment {
    
    var name: String
    var vibe: String
    var venue: [String]
    var food: Bool
    var price: String
    var location: Int
    
    
    init(name: String, vibe: String, venue: [String], food: Bool, price: String, location: Int) {
        self.name = name
        self.vibe = vibe
        self.venue = venue
        self.food = food
        self.price = price
        self.location = location
    }
    
    
    
}
