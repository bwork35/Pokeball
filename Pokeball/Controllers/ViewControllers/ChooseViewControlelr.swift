//
//  PickTwoViewController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/15/21.
//

import UIKit

class ChooseViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var ellaView: UIView!
    @IBOutlet weak var nathanView: UIView!
    @IBOutlet weak var mrbView: UIView!
    @IBOutlet weak var ellaCountLabel: UILabel!
    @IBOutlet weak var nathanCountLabel: UILabel!
    @IBOutlet weak var mrbCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var cvContainingView: UIView!
    @IBOutlet weak var toDetailButton: UIBarButtonItem!
    
    //MARK: - Properties    
    var isEllasTurn = true
    var isNathansTurn = false
    var isMRBsTurn = false
    
    var ellaPicks: [Int] = []
    var nathansPicks: [Int] = []
    var mrbsPicks: [Int] = []
    
    var isRevealed = false
    
    var pokeballs: [Pokeball] = []
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        GameController.shared.loadFromPersistenceStore()
        
        toDetailButton.isEnabled = false
        updateTurn()
        rerandomizePokemon()
    }
    
    //MARK: - Actions
    @IBAction func ellaButtonTapped(_ sender: Any) {
        guard isRevealed == false else {return}
        isEllasTurn = true
        isNathansTurn = false
        isMRBsTurn = false
        updateTurn()
    }
    
    @IBAction func nathanButtonTapped(_ sender: Any) {
        guard isRevealed == false else {return}
        isEllasTurn = false
        isNathansTurn = true
        isMRBsTurn = false
        updateTurn()
    }
    
    @IBAction func mrbButtonTapped(_ sender: Any) {
        guard isRevealed == false else {return}
        isEllasTurn = false
        isNathansTurn = false
        isMRBsTurn = true
        updateTurn()
    }
    
    @IBAction func revealButtonTapped(_ sender: Any) {
        guard ellaPicks.count == 2, nathansPicks.count == 2, mrbsPicks.count == 2 else {return}
        if isRevealed {
            reset()
        } else {
            isRevealed = true
            isEllasTurn = false
            isNathansTurn = false
            isMRBsTurn = false
            toDetailButton.isEnabled = true
            updateTurn()
            revealButton.setTitle("Reset", for: .normal)
            transferColors()
            collectionView.reloadData()
        }
    }
    
    //MARK: - Helper Methods
    func updateTurn() {
        ellaView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nathanView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mrbView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        if isEllasTurn {
            ellaView.backgroundColor = #colorLiteral(red: 0.4746502042, green: 0.824804008, blue: 0.7766732574, alpha: 1)
        } else if isNathansTurn {
            nathanView.backgroundColor = #colorLiteral(red: 0.4740880728, green: 0.7233807445, blue: 0.9992566705, alpha: 1)
        } else if isMRBsTurn {
            mrbView.backgroundColor = #colorLiteral(red: 0.9733943343, green: 0.9809337258, blue: 0.5477988124, alpha: 1)
        }
    }
    
    func updateCounts() {
        ellaCountLabel.text = String(2 - ellaPicks.count)
        nathanCountLabel.text = String(2 - nathansPicks.count)
        mrbCountLabel.text = String(2 - mrbsPicks.count)
    }
    
    func printPicks() {
        print("ellas", ellaPicks)
        print("nathans", nathansPicks)
        print("mrbs", mrbsPicks)
    }
    
    func reset() {
        isRevealed = false
        revealButton.setTitle("Reveal", for: .normal)
        collectionView.reloadData()
        ellaPicks = []
        nathansPicks = []
        mrbsPicks = []
        isEllasTurn = true
        isNathansTurn = false
        isMRBsTurn = false
        toDetailButton.isEnabled = false
        updateTurn()
        updateCounts()
        rerandomizePokemon()
    }
    
    func rerandomizePokemon() {
        func fetchPokemon(from id: Int) {
            PokemonController.fetchPokemonWith(searchTerm: String(id)) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let pokemon):
                        fetchSpriteFor(pokemon)
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
        func fetchSpriteFor(_ pokemon: Pokemon) {
            PokemonController.fetchSprite(for: pokemon) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let sprite):
                        let newPokeball = Pokeball(id: pokemon.id, pokemon: pokemon, pokeImage: sprite)
                        self.pokeballs.append(newPokeball)
                        group.leave()
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
        pokeballs = []
        let range = (1...898)
        let group = DispatchGroup()
        for _ in 1...9 {
            group.enter()
            let randomID = range.randomElement() ?? 1
            fetchPokemon(from: randomID)
        }
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func transferColors() {
        for i in 0...PokeballController.shared.zeros.count-1 {
            pokeballs[i].selector = PokeballController.shared.zeros[i].selector
            pokeballs[i].wasSelected = PokeballController.shared.zeros[i].wasSelected
            
            PokeballController.shared.zeros[i].selector = "nil"
            PokeballController.shared.zeros[i].wasSelected = false
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destination = segue.destination as? ChooseDetailTableViewController else {return}
            destination.pokeballs = pokeballs
        }
    }

} //End of class

extension ChooseViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCollectionViewCell else {return UICollectionViewCell()}
        
        if isRevealed {
            cell.pokeball = pokeballs[indexPath.row]
        } else {
            cell.pokeball = PokeballController.shared.zeros[indexPath.row]
        }
        
        cell.delegate = self
        
        return cell
    }
} //End of extension

extension ChooseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameWidth = view.frame.width
        let frameHeight = view.frame.height
        let width = view.frame.width / 3
        let smallWidth = view.frame.width / 4
        
        if frameHeight / frameWidth > 1.5 {
            return CGSize(width: width - 20, height: width - 20)
        } else {
            return CGSize(width: smallWidth, height: smallWidth)
        }
    }
} //End of extension

extension ChooseViewController: PokeballSelectorDelegate {
    func pokeballWasSelectedFor(cell: PokeCollectionViewCell, pokeball: Pokeball) {
        guard isRevealed == false else {return}
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        if isEllasTurn {
            guard ellaPicks.count < 2 else {return}
            ellaPicks.append(indexPath.row)
            pokeball.selector = "ella"
            cell.updateColorForSelector()
        } else if isNathansTurn {
            guard nathansPicks.count < 2 else {return}
            nathansPicks.append(indexPath.row)
            pokeball.selector = "nathan"
            cell.updateColorForSelector()
        } else {
            guard mrbsPicks.count < 2 else {return}
            mrbsPicks.append(indexPath.row)
            pokeball.selector = "mrb"
            cell.updateColorForSelector()
        }
        PokeballController.shared.toggleWasSelected(pokeball: pokeball)
        updateCounts()
    }
    
    func unselectPokeballFor(cell: PokeCollectionViewCell, pokeball: Pokeball) {
        guard isRevealed == false else {return}
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        if isEllasTurn {
            guard let index = ellaPicks.firstIndex(of: indexPath.row) else {return}
            ellaPicks.remove(at: index)
        } else if isNathansTurn {
            guard let index = nathansPicks.firstIndex(of: indexPath.row) else {return}
            nathansPicks.remove(at: index)
        } else {
            guard let index = mrbsPicks.firstIndex(of: indexPath.row) else {return}
            mrbsPicks.remove(at: index)
        }
        PokeballController.shared.toggleWasSelected(pokeball: pokeball)
        pokeball.selector = "nil"
        cell.updateColorForSelector()
        updateCounts()
    }
    
    func presentPokeError(_ error: LocalizedError) {
        self.presentErrorToUser(localizedError: error)
    }
} //End of extension
