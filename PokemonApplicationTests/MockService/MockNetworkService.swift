//
//  MockNetworkService.swift
//  PokemonApplicationTests
//
//  Created by And Nik on 01.02.23.
//

import Foundation
@testable import PokemonApplication

final class MockNetworkService: NetworkServiceProtocol{
    
    var pokemonsUrls: [PokemonUrl]!
    var pokemonUrl: PokemonUrl!
    
    init(pokemonsUrls: [PokemonUrl], pokemonUrl: PokemonUrl) {
        self.pokemonsUrls = pokemonsUrls
        self.pokemonUrl = pokemonUrl
    }
    
    func getPokemonsUrlsFromNetwork(completion: @escaping ([PokemonUrl]?) -> Void) {
        completion(pokemonsUrls)
    }
    
    func getPokemonFromUrl(pokemonsUrls: [PokemonUrl], number: Int, completion: @escaping (Pokemon?) -> Void) {
        let pokemonType = PokemonType(name: "type")
        let types = Types(type: pokemonType)
        let sprite = Sprites(frontDefaultUrl: URL(fileURLWithPath: ""))
        let pokemon = Pokemon(name: "pokemon", sprites: sprite, types: [types], weight: 20, height: 10)
        
        completion(pokemon)
    }
    
    func getData<T>(url: URL, completion: @escaping (T?) -> Void) where T : Decodable {
    }
    
}
