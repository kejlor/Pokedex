//
//  PokemonDetailService.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import Foundation
import Combine
import SwiftUI

class PokemonDetailService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private var linkSubscription: AnyCancellable?
    private var spriteURL: PokemonSpritesModel? = nil
    private let pokedexEntry: PokedexModel
    
    init(pokedexEntry: PokedexModel) {
        self.pokedexEntry = pokedexEntry
        getSpriteURL()
        downloadSpriteImage()
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
    
    private func getSpriteURL() {
        guard let url = URL(string: pokedexEntry.url) else { return }
//        print(url)
        linkSubscription = NetworkingManager.download(url: url)
            .decode(type: PokemonSpritesModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedSpriteURL) in
//                guard let self = self, let downloadedSprite = returnedSpriteURL.frontDefault else { return }
                self?.spriteURL = returnedSpriteURL
                self?.linkSubscription?.cancel()
            })
//        print(self.spriteURL?.frontDefault!)
    }
    
    private func downloadSpriteImage() {
        guard let url = URL(string: spriteURL?.frontDefault ?? "") else { return }
        print("getting image")
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
            })
    }
}
