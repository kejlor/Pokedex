//
//  HomeView.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 28/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        VStack {
            allPokemonsList
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    private var allPokemonsList: some View {
        List {
            ForEach(vm.allPokemons) { pokemon in
                PokedexRowView(pokedexEntry: pokemon)
            }
        }
        .listStyle(PlainListStyle())
    }
}
