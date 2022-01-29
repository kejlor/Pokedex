//
//  PokemonSpritesModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation

struct PokemonSpritesModel: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
