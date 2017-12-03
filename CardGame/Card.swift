//
//  Card.swift
//  CardGame
//
//  Created by Curtis Wiseman on 12/2/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import Foundation

struct Cards{
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentfier() -> Int{
        Cards.identifierFactory += 1
        return Cards.identifierFactory
    }
    
    init() {
        self.identifier = Cards.getUniqueIdentfier()
    }
}
