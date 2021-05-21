//
//  Pokemon.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/3/21.
//

import UIKit

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: Sprite
    let types: [Type]
}

struct Sprite: Decodable {
    let front_default: URL
}

struct Type: Decodable {
    let type: TypeObject
}

struct TypeObject: Decodable {
    let name: String
}
