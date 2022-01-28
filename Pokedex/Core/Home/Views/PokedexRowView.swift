//
//  PokedexRowView.swift
//  Pokedex
//
//  Created by Bartosz Wojtkowiak on 28/01/2022.
//

import SwiftUI

struct PokedexRowView: View {
    
    let pokedexEntry: PokedexModel
    
    var body: some View {
        HStack {
            Text(pokedexEntry.name)
        }
    }
}

struct PokedexRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokedexRowView(pokedexEntry: dev.pokedexEntry)
                .previewLayout(.sizeThatFits)
            
            PokedexRowView(pokedexEntry: dev.pokedexEntry)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
