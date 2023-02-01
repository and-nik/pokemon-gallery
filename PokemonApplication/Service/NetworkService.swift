//
//  NetworkService.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit
import Network

protocol NetworkServiceProtocol{
    func getPokemonsUrlsFromNetwork(completion: @escaping ([PokemonUrl]?) -> Void)
    func getPokemonFromUrl(pokemonsUrls: [PokemonUrl], number: Int, completion: @escaping (Pokemon?) -> Void)
}

final class NetworkService: NetworkServiceProtocol{

    public func getPokemonsUrlsFromNetwork(completion: @escaping ([PokemonUrl]?) -> Void){
        let pokemonsStringUrl = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=1300"
        guard let url = URL(string: pokemonsStringUrl) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error)
                completion(nil)
                return
            }
            guard let data else {
                completion(nil)
                return
            }
            do{
                let object = try JSONDecoder().decode(ListOfPokemonsUrls.self, from: data)
                let pokemonsUrls = object.pokemonsUrls
                completion(pokemonsUrls)
            }
            catch{
                print(error)
                completion(nil)
            }
        }.resume()
        
    }
    
    public func getPokemonFromUrl(pokemonsUrls: [PokemonUrl], number: Int, completion: @escaping (Pokemon?) -> Void) {
        let url = pokemonsUrls[number].url

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error)
                completion(nil)
                return
            }
            guard let data else {
                completion(nil)
                return
            }
            do{
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
            }
            catch{
                print(error)
                completion(Pokemon())
            }
        }.resume()
    }
}

