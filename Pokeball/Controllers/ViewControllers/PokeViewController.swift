//
//  PokeViewController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/3/21.
//

import UIKit

class PokeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var peakButton: UIButton!
    
    //MARK: - Properties
    var isRevealed = true
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        peakButton.isEnabled = false
        
        fetchPokemon(searchTerm: "pikachu")
    }
    
    //MARK: - Actions
    @IBAction func randomButtonTapped(_ sender: Any) {
        if isRevealed {
            fetchRandom()
            pokeNameLabel.isHidden = true
            pokeImageView.isHidden = true
            pokeIDLabel.isHidden = true
            randomButton.setTitle("Show Me", for: .normal)
            peakButton.isEnabled = true
        } else {
            pokeNameLabel.isHidden = false
            randomButton.setTitle("Randomize", for: .normal)
            peakButton.isEnabled = false
        }
        isRevealed.toggle()
    }
    
    @IBAction func peakButtonTapped(_ sender: Any) {
        pokeNameLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.pokeNameLabel.isHidden = true
        }
    }
    
    //MARK: - Helper Methods
    func fetchPokemon(searchTerm: String) {
        PokemonController.fetchPokemonWith(searchTerm: searchTerm) { (result) in
            switch result {
            case .success(let pokemon):
                self.fetchImageAndUpdateViews(for: pokemon)
            case .failure(let error):
                self.presentErrorOnMainThread(error: error)
            }
        }
    }
    
    func fetchRandom() {
        PokemonController.fetchRandomPokemon { (result) in
            switch result {
            case .success(let pokemon):
                self.fetchImageAndUpdateViews(for: pokemon)
            case .failure(let error):
                self.presentErrorOnMainThread(error: error)
            }
        }
    }
    
    func fetchImageAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    if self.isRevealed {
                        self.pokeNameLabel.isHidden = false
                    }
                    self.pokeImageView.isHidden = false
                    self.pokeIDLabel.isHidden = false
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeImageView.image = sprite
                    self.pokeIDLabel.text = String(pokemon.id)
                    pokemon.types.forEach({ print($0.type.name) })
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func presentErrorOnMainThread(error: LocalizedError) {
        DispatchQueue.main.async {
            self.presentErrorToUser(localizedError: error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
