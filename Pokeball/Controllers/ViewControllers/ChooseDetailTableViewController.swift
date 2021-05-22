//
//  ChooseDetailTableViewController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/21/21.
//

import UIKit

class ChooseDetailTableViewController: UITableViewController {

    //MARK: - Properties
    var pokeballs: [Pokeball]?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helper Methods

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokeballs = pokeballs else {return 0}
        return pokeballs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeInfoCell", for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        
        guard let pokeballs = pokeballs else {return UITableViewCell()}
        
        let pokeball = pokeballs[indexPath.row]
        
        cell.pokeball = pokeball
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }

} //End of class
