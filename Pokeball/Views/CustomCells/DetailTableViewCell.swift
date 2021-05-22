//
//  DetailTableViewCell.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/21/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var elleFavoriteButton: UIButton!
    @IBOutlet weak var nathanFavoriteButton: UIButton!
    @IBOutlet weak var mrbFavoriteButton: UIButton!
    
    //MARK: - Properties
    var pokeball: Pokeball? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    @IBAction func ellaFavoriteButtonTapped(_ sender: Any) {
        print("ella fav")
    }
    
    @IBAction func nathanFavoriteButtonTapped(_ sender: Any) {
        print("nathan fav")
    }
    
    @IBAction func mrbFavoriteButtonTapped(_ sender: Any) {
        print("m r b fav")
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let pokeball = pokeball else {return}
        pokeImageView.image = pokeball.pokeImage
        pokeNameLabel.text = pokeball.pokemon?.name
        pokeIDLabel.text = String(pokeball.id)
        
        GameController.shared.ellaFavorites.contains(pokeball.id) ? elleFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : elleFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        GameController.shared.nathanFavorites.contains(pokeball.id) ? nathanFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : nathanFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
       
        GameController.shared.mrbFavorites.contains(pokeball.id) ? mrbFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : mrbFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    

} //End of class
