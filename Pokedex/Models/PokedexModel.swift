//
//  PokedexModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 28/01/2022.
//

import Foundation

/*
 URL: https://pokeapi.co/api/v2/pokemon?limit=151
 
 JSON Response:
 {
   "count": 1118,
   "next": "https://pokeapi.co/api/v2/pokemon?offset=100&;amp;limit=100",
   "previous": null,
   "results": [
     {
       "name": "bulbasaur",
       "url": "https://pokeapi.co/api/v2/pokemon/1/"
     }]
 }
 */

struct PokedexModel: Identifiable, Codable {
    var id: UUID {
        return UUID()
    }
    let name: String
    let url: String
}
