//
//  GameController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/21/21.
//

import Foundation

class GameController {
    
    static let shared = GameController()
    
    var favorites: [[Int]] = [[], [], [], []]
//    var ellaFavorites: [Int] = []
//    var nathanFavorites: [Int] = []
//    var mrbFavorites: [Int] = []
    
    
    //MARK: - Methods
    func toggleFavorite(arrayIndex: Int, id: Int) {
        if favorites[arrayIndex].contains(id) {
            removePokemonFromFavorites(arrayIndex: arrayIndex, id: id)
        } else {
            addPokemonToFavorites(arrayIndex: arrayIndex, id: id)
        }
    }
    
    func addPokemonToFavorites(arrayIndex: Int, id: Int) {
        favorites[arrayIndex].append(id)
        saveToPersistenceStore()
    }
    
    func removePokemonFromFavorites(arrayIndex: Int, id: Int) {
        guard let index = favorites[arrayIndex].firstIndex(of: id) else {return}
        favorites[arrayIndex].remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pokeball.json")
        return fileURL
    }
    
    //Save
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(favorites) // <-- Change S.O.T
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our favorites: \(error) --- \(error.localizedDescription)")
        }
    }
    
    //Load
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            favorites = try jsonDecoder.decode([[Int]].self, from: data)
        } catch {
            print("Error decoding our data into favorites \(error) --- \(error.localizedDescription)")
        }
    }
    
} //End of class
