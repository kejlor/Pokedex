//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 28/01/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allPokemons: [PokedexModel] = []
    @Published var searchText = ""
    
    private let pokemonDataService = PokemonDataService()
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // update allPokemons
        $searchText
            .combineLatest(pokemonDataService.$allPokemons)
            .map(filterPokemons)
            .sink { [weak self] (returnedPokemons) in
                self?.allPokemons = returnedPokemons
            }
            .store(in: &anyCancellables)
    }
    
    private func filterPokemons(text: String, pokemons: PokemonModel) -> [PokedexModel] {
        guard !text.isEmpty else {
            return pokemons.results
        }
        
        let lowercasedText = text.lowercased()
        let pokedexModels = pokemons.results
        
        return pokedexModels.filter { (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(lowercasedText) ||
            pokemon.url.lowercased().contains(lowercasedText)
        }
    }
    
    func reloadData() {
        pokemonDataService.getPokemons()
    }
}
