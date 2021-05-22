//
//  PokeCollectionViewCell.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/15/21.
//

import UIKit

protocol PokeballSelectorDelegate: AnyObject {
    func pokeballWasSelectedFor(cell: PokeCollectionViewCell, pokeball: Pokeball)
    
    func unselectPokeballFor(cell: PokeCollectionViewCell, pokeball: Pokeball)
    
    func presentPokeError(_ error: LocalizedError)
}

class PokeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var pokeballImageView: UIImageView!
    @IBOutlet var equalWidths100: NSLayoutConstraint!
    @IBOutlet var equalWidths75: NSLayoutConstraint!
    
    //MARK: - Properties
    var pokeball: Pokeball? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: PokeballSelectorDelegate?
    
    //MARK: - Actions
    @IBAction func selectButtonTapped(_ sender: Any) {
        guard let pokeball = pokeball else {return}
        if pokeball.wasSelected {
            delegate?.unselectPokeballFor(cell: self, pokeball: pokeball)
        } else {
            delegate?.pokeballWasSelectedFor(cell: self, pokeball: pokeball)
        }
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let pokeball = pokeball else {return}
        
        if pokeball.id == 0 {
            //pokeballImageView.image = UIImage(systemName: "circle.tophalf.fill")
            pokeballImageView.image = UIImage(named: "pkball")
            equalWidths100.isActive = false
            equalWidths75.isActive = true
            layoutIfNeeded()
        } else {
            pokeballImageView.image = pokeball.pokeImage
            self.equalWidths75.isActive = false
            self.equalWidths100.isActive = true
            self.layoutIfNeeded()
//            fetchPokemonWithID(pokeball.id)
        }
        updateColorForSelector()
    }
    
    func updateColorForSelector() {
        guard let pokeball = pokeball else {return}
        if pokeball.selector == "ella" {
            self.backgroundColor = #colorLiteral(red: 0.4746502042, green: 0.824804008, blue: 0.7766732574, alpha: 1)
        } else if pokeball.selector == "nathan" {
            self.backgroundColor = #colorLiteral(red: 0.4740880728, green: 0.7233807445, blue: 0.9992566705, alpha: 1)
        } else if pokeball.selector == "mrb" {
            self.backgroundColor = #colorLiteral(red: 0.9733943343, green: 0.9809337258, blue: 0.5477988124, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
    }
    
//    func fetchPokemonWithID(_ id: Int) {
//        PokemonController.fetchPokemonWith(searchTerm: String(id)) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let pokemon):
//                    self.fetchSpriteFor(pokemon)
//                case .failure(let error):
//                    self.delegate?.presentPokeError(error)
//                }
//            }
//        }
//    }
//
//    func fetchSpriteFor(_ pokemon: Pokemon) {
//        PokemonController.fetchSprite(for: pokemon) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let sprite):
//                    self.equalWidths75.isActive = false
//                    self.equalWidths100.isActive = true
//                    self.layoutIfNeeded()
//                    self.pokeballImageView.image = sprite
//                case .failure(let error):
//                    self.delegate?.presentPokeError(error)
//                }
//            }
//        }
//    }
    
} //End of class
