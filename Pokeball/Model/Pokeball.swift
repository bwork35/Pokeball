//
//  Pokeball.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/20/21.
//

import UIKit.UIImage

class Pokeball {
    
    var id: Int
    var wasSelected: Bool
    var selector: String
    var pokemon: Pokemon?
    var pokeImage: UIImage?
    
    init(id: Int, wasSelected: Bool = false, selector: String = "nil", pokemon: Pokemon?, pokeImage: UIImage? = nil) {
        self.id = id
        self.wasSelected = wasSelected
        self.selector = selector
        self.pokemon = pokemon
        self.pokeImage = pokeImage
    }
    
} //End of class
 
extension Pokeball: Equatable {
    static func == (lhs: Pokeball, rhs: Pokeball) -> Bool {
        return lhs.id == rhs.id && rhs.wasSelected == rhs.wasSelected && lhs.selector == rhs.selector && lhs.pokemon == rhs.pokemon
    }
} //End of extension
