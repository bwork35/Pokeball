//
//  Pokeball.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/20/21.
//

import Foundation

class Pokeball {
    
    var id: Int
    var wasSelected: Bool
    var selector: String
    
    init(id: Int, wasSelected: Bool = false, selector: String = "nil") {
        self.id = id
        self.wasSelected = wasSelected
        self.selector = selector
    }
    
} //End of class
 
extension Pokeball: Equatable {
    static func == (lhs: Pokeball, rhs: Pokeball) -> Bool {
        return lhs.id == rhs.id && rhs.wasSelected == rhs.wasSelected && lhs.selector == rhs.selector
    }
} //End of extension
