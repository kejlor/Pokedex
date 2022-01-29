//
//  PokemonDetailsModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation

struct PokemonDetailsModel: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    var sprite: PokemonSpritesModel
}
