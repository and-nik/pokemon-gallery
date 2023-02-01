//
//  MockDataHandlerService.swift
//  PokemonApplicationTests
//
//  Created by And Nik on 01.02.23.
//

import Foundation
@testable import PokemonApplication

final class MockDataHandlerService: DataHandlerServiceProtocol{
    
    func loadData() -> [PokemonApplication.Pokemon] {
        let pokemonType = PokemonType(name: "type")
        let types = Types(type: pokemonType)
        let sprite = Sprites(frontDefaultUrl: URL(fileURLWithPath: ""))
        let pokemon = Pokemon(name: "pokemon", sprites: sprite, types: [types], weight: 20, height: 10)
        return [pokemon]
    }
    
    func saveData(pokemons: [PokemonApplication.Pokemon]) {
    }
    
}
