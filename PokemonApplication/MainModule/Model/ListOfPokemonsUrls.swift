//
//  Object.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import Foundation

struct ListOfPokemonsUrls: Decodable{
    
    public let pokemonsUrls: [PokemonUrl]
    
    init(pokemonsUrls: [PokemonUrl] = [PokemonUrl]()) {
        self.pokemonsUrls = pokemonsUrls
    }
    
    private enum CodingKeys: String, CodingKey{
        case pokemonsUrls = "results"
    }
}
