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
    func getData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void)
}

final class NetworkService: NetworkServiceProtocol{

    public func getPokemonsUrlsFromNetwork(completion: @escaping ([PokemonUrl]?) -> Void) {
        let pokemonsStringUrl = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=1300"
        guard let url = URL(string: pokemonsStringUrl) else {return}
        self.getData(url: url) { (_ result: ListOfPokemonsUrls?) in
            guard let listOfPokemonsUrls = result else {
                completion(nil)
                return
            }
            let pokemonsUrls = listOfPokemonsUrls.pokemonsUrls
            completion(pokemonsUrls)
        }
    }
    
    public func getPokemonFromUrl(pokemonsUrls: [PokemonUrl], number: Int, completion: @escaping (Pokemon?) -> Void) {
        let url = pokemonsUrls[number].url
        self.getData(url: url) { pokemon in
            completion(pokemon)
        }
    }
    
    public func getData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { completion(nil) }
            guard let data else {
                completion(nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result)
            }
            catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}

