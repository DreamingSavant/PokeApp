//
//  PokeModel.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import Foundation


struct PokemonPage: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}


// MARK - Add for detail here
struct PokemonDetail: Decodable {
    let height: Int
    let name: String
    let id: Int
    let sprites: Sprites
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case height
        case name
        case id
        case sprites, weight
    }
}

class Sprites: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    }
