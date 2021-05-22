//
//  PokeController.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/3/21.
//

import UIKit

//https://pokeapi.co/api/v2/pokemon/

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndPoint = "pokemon"
    
    static func fetchPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon, PokeError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm)
        
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchRandomPokemon(completion: @escaping (Result<Pokemon, PokeError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        
        let randomID = (1...898).randomElement() ?? 1
        
        let finalURL = pokemonURL.appendingPathComponent(String(randomID))
        
//        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokeError>) -> Void) {
        let url = pokemon.sprites.front_default
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            guard let sprite = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(sprite))
        }.resume()
    }
} //End of class
