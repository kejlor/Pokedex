//
//  PokemonSpriteViewModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation
import Combine

class PokemonSpriteViewModel: ObservableObject {
    
    @Published var pokemonDetails: PokemonDetailsModel? = nil
    
    private let pokedexEntry: PokedexModel
    private let dataService: PokemonDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(pokedexEntry: PokedexModel) {
        self.pokedexEntry = pokedexEntry
        self.dataService = PokemonDetailService(pokedexEntry: pokedexEntry)
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$spriteURL
            .sink { [weak self] (_) in
                
            } receiveValue: { [weak self] (returnedPokemonDetail) in
                self?.pokemonDetails = returnedPokemonDetail
            }
            .store(in: &cancellables)
    }
}
