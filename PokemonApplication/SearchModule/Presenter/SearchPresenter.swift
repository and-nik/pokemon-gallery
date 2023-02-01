//
//  SearchPresenter.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import Foundation

protocol SearchViewControllerProtocol: AnyObject{
    func presentPokemonInfoVC(VC: PokemonInfoViewController)
}

protocol SearchPresenterProtocol: AnyObject{
    var pokemonsUrls: [PokemonUrl]? {get set}
    
    init(viewController: SearchViewControllerProtocol, pokemonsUrls: [PokemonUrl], networkService: NetworkServiceProtocol)
    func didTapAtCell(number: Int)
    func getPokemon(whith number: Int, completion: @escaping (Pokemon, Data) -> Void)
}

final class SearchPresenter: SearchPresenterProtocol{
    
    private weak var viewController: SearchViewControllerProtocol?
    
    public var pokemonsUrls: [PokemonUrl]?
    public let networkService: NetworkServiceProtocol!
    
    required init(viewController: SearchViewControllerProtocol, pokemonsUrls: [PokemonUrl], networkService: NetworkServiceProtocol) {
        self.viewController = viewController
        self.pokemonsUrls = pokemonsUrls
        self.networkService = networkService
    }
    
    public func didTapAtCell(number: Int){
        guard let pokemonsUrls = self.pokemonsUrls,
              let VC = self.viewController else {return}
        
        self.networkService.getPokemonFromUrl(pokemonsUrls: pokemonsUrls, number: number) { pokemon in
            DispatchQueue.main.async {
                guard let pokemon else {return}
                VC.presentPokemonInfoVC(VC: Builder.shared.createPokemonInfoVC(pokemon: pokemon))
            }
        }
    }
    
    public func getPokemon(whith number: Int, completion: @escaping (Pokemon, Data) -> Void){
        guard let pokemonsUrls = self.pokemonsUrls else {return}
        
        self.networkService.getPokemonFromUrl(pokemonsUrls: pokemonsUrls, number: number) { pokemon in
            guard let pokemon else {return}
            pokemon.sprites.getImage(url: pokemon.sprites.frontDefaultUrl) { image in
                guard let imageData = image.pngData() else {return}
                completion(pokemon, imageData)
            }
        }
    }
    
}
