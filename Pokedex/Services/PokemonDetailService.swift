//
//  PokemonDetailService.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation
import Combine

class PokemonDetailService {
    
    @Published var spriteURL: PokemonDetailsModel? = nil
    
    private var linkSubscription: AnyCancellable?
    private let pokedexEntry: PokedexModel
    
    init(pokedexEntry: PokedexModel) {
        self.pokedexEntry = pokedexEntry
        getSprite()
    }
    
//    func getSprite(url: String, completion:@escaping (PokemonSpritesModel) -> ()) {
//        guard let url = URL(string: url) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            let pokemonSprite = try! JSONDecoder().decode(PokemonDetailsModel.self, from: data)
//
//            DispatchQueue.main.async {
//                completion(pokemonSprite.sprites)
//            }
//        }.resume()
//    }
    
    private func getSprite() {
        guard let url = URL(string: pokedexEntry.url) else { return }
        linkSubscription = NetworkingManager.download(url: url)
            .decode(type: PokemonDetailsModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedSpriteURL) in
                self?.spriteURL = returnedSpriteURL
                self?.linkSubscription?.cancel()
            })
    }
}
