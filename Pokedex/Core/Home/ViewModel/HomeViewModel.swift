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
    
    private let pokedexDataService = PokedexDataService()
    private var anyCancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // update allPokemons
        $searchText
            .combineLatest(pokedexDataService.$allPokemons)
            .map(filterPokemons)
            .sink { [weak self] (returnedPokemons) in
                self?.allPokemons = returnedPokemons
            }
            .store(in: &anyCancellables)
    }
        
    private func filterPokemons(text: String, pokemons: [PokedexModel]) -> [PokedexModel] {
        guard !text.isEmpty else {
            return pokemons
        }
        
        let lowercasedText = text.lowercased()
        
        return pokemons.filter { (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(lowercasedText) ||
            pokemon.url.lowercased().contains(lowercasedText)
        }
    }
    
    func reloadData() {
        pokedexDataService.getPokemons()
    }
}
