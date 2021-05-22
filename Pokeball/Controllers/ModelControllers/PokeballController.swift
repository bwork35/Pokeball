//
//  PokeballController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/20/21.
//

import UIKit

class PokeballController {
    
    static let shared = PokeballController()
    
//    let starters: [Pokeball] = [
//        Pokeball(id: 1),
//        Pokeball(id: 2),
//        Pokeball(id: 3),
//        Pokeball(id: 4),
//        Pokeball(id: 5),
//        Pokeball(id: 6),
//        Pokeball(id: 7),
//        Pokeball(id: 8),
//        Pokeball(id: 9)
//    ]
    
    let zeros: [Pokeball] = [
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil),
        Pokeball(id: 0, pokemon: nil)
    ]
    
    var pokeballs: [Pokeball] = []
    
    let range = (1...898)
    
    //MARK: - Methods
    func toggleWasSelected(pokeball: Pokeball) {
        pokeball.wasSelected.toggle()
    }
    
    func transferColors() {
        for i in 0...zeros.count-1 {
            pokeballs[i].selector = zeros[i].selector
            pokeballs[i].wasSelected = zeros[i].wasSelected
            
            zeros[i].selector = "nil"
            zeros[i].wasSelected = false
        }
    }
    
    func randomizePokemon() {
        var placeholder: [Pokeball] = []
        for _ in 1...9 {
            let randomID = range.randomElement() ?? 1
            let newPoke = Pokeball(id: randomID, pokemon: nil) //BWORK
            placeholder.append(newPoke)
        }
        pokeballs = placeholder
    }

    
} //End of class
