//
//  FavoritesViewController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/21/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Actions
    @IBAction func selectedSegmentValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    //MARK: - Helper Methods



} //End of class

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return GameController.shared.favorites[1].count
        case 1:
            return GameController.shared.favorites[2].count
        case 2:
            return GameController.shared.favorites[3].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        var text = ""
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            text = String(GameController.shared.favorites[1][indexPath.row])
        case 1:
            text = String(GameController.shared.favorites[2][indexPath.row])
        case 2:
            text = String(GameController.shared.favorites[3][indexPath.row])
        default:
            text = "ERROR"
        }
        
        cell.textLabel?.text = text
        
        return cell
    }
} //End of extension
