//
//  PokemonSpriteView.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 29/01/2022.
//

import SwiftUI

struct PokemonSpriteView: View {
    
    @StateObject var vm: PokemonSpriteViewModel
    
    init(pokedexEntry: PokedexModel) {
        _vm = StateObject(wrappedValue: PokemonSpriteViewModel(pokedexEntry: pokedexEntry))
    }
    
    var body: some View {
        ZStack {
            if let spriteURL = URL(string: vm.pokemonDetails?.frontDefault ?? "") {
                AsyncImage(url: spriteURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

struct PokemonSpriteView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSpriteView(pokedexEntry: dev.pokedexEntry)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
