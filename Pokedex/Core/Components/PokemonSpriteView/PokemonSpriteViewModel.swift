//
//  PokemonSpriteViewModel.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation
import Combine
import SwiftUI

class PokemonSpriteViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private let pokedexEntry: PokedexModel
    private let dataService: PokemonDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(pokedexEntry: PokedexModel) {
        self.pokedexEntry = pokedexEntry
        self.dataService = PokemonDetailService(pokedexEntry: pokedexEntry)
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
