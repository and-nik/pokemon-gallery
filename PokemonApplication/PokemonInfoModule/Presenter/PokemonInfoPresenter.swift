//
//  PokemonInfoPresenter.swift
//  Pokemon Application
//
//  Created by And Nik on 25.01.23.
//

import Foundation

protocol PokemonInfoViewControllerProtocol: AnyObject{
    func setPokemon(pokemon: Pokemon)
    func viewWillAppear(_ animated: Bool)
}

protocol PokemonInfoPresenterProtocol: AnyObject{
    
    var pokemon: Pokemon? {get set}
    
    init(pokemonInfoViewController: PokemonInfoViewControllerProtocol, pokemon: Pokemon, datahandlerService: DataHandlerServiceProtocol)
    
    func readyToSetPokemon()
    func isPokemonFavorite() -> Bool
    func didTabAtFavoriteButton()
}

final class PokemonInfoPresenter: PokemonInfoPresenterProtocol{
    
    public var pokemon: Pokemon?
    
    private weak var pokemonInfoViewController: PokemonInfoViewControllerProtocol?
    private let datahandlerService: DataHandlerServiceProtocol!
    
    required init(pokemonInfoViewController: PokemonInfoViewControllerProtocol, pokemon: Pokemon, datahandlerService: DataHandlerServiceProtocol) {
        self.pokemonInfoViewController = pokemonInfoViewController
        self.pokemon = pokemon
        self.datahandlerService = datahandlerService
    }
    
    public func readyToSetPokemon(){
        guard let pokemonInfoVC = self.pokemonInfoViewController,
              let pokemon = self.pokemon else {return}
        pokemonInfoVC.setPokemon(pokemon: pokemon)
    }
    
    public func isPokemonFavorite() -> Bool {
        guard let pokemon = self.pokemon else {return false}
        let pokemons = self.datahandlerService.loadData()
        
        return pokemons.contains(where: {$0.name == pokemon.name})
    }
    
    public func didTabAtFavoriteButton(){
        guard let pokemonInfoVC = self.pokemonInfoViewController,
              let pokemon = self.pokemon else {return}
        
        var pokemons = self.datahandlerService.loadData()
        
        if self.isPokemonFavorite(){
            pokemons.removeAll {$0.name == pokemon.name}
            self.datahandlerService.saveData(pokemons: pokemons)
            pokemonInfoVC.viewWillAppear(true) //for change favoritesButton.tintColor to = .systemGray3
        } else{
            let imageUrl = pokemon.sprites.frontDefaultUrl
            pokemon.sprites.getImage(url: imageUrl) { image in
                pokemon.imageData = image.pngData()
                pokemons.append(pokemon)
                self.datahandlerService.saveData(pokemons: pokemons)
                pokemonInfoVC.viewWillAppear(true) //for change favoritesButton.tintColor to = .systemYellow
            }
        }
    }
    
}
