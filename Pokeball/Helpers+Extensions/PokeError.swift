//
//  PokeError.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/3/21.
//

import Foundation

enum PokeError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "Unable to turn the data into an image."
        }
    }
} //End of enum
