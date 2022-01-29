//
//  PokedexDataService.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 28/01/2022.
//

import Foundation
import Combine

class PokemonDataService {
    
    @Published var allPokemons = PokemonModel(results: [PokedexModel]())
    
    var pokemonSubscription: AnyCancellable?
    
    init() {
        getPokemons()
    }
    
    func getPokemons() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        print("getting pokemons")
        
        pokemonSubscription = NetworkingManager.download(url: url)
            .decode(type: PokemonModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedPokemons) in
                self?.allPokemons = returnedPokemons
                self?.pokemonSubscription?.cancel()
            })
    }
}
