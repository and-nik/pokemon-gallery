//
//  FavoritesPresenter.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import Foundation

protocol FavoritesViewControllerProtocol: AnyObject{
    func presentPokemonInfoVC(VC: PokemonInfoViewController)
}

protocol FavoritesPresenterProtocol: AnyObject{
    
    var favoritesPokemons: [Pokemon]? {get set}
    
    init(viewController: FavoritesViewControllerProtocol, dataHandlerService: DataHandlerServiceProtocol)
    
    func reloadData()
    func didTapAtCell(number: Int)
}

final class FavoritesPresenter: FavoritesPresenterProtocol{
    
    public var favoritesPokemons: [Pokemon]?
    
    private weak var viewController: FavoritesViewControllerProtocol?
    private let dataHandlerService: DataHandlerServiceProtocol!
    
    required init(viewController: FavoritesViewControllerProtocol, dataHandlerService: DataHandlerServiceProtocol) {
        self.viewController = viewController
        self.dataHandlerService = dataHandlerService
        self.reloadData()
    }
    
    public func reloadData() {
        self.favoritesPokemons = self.dataHandlerService.loadData()
    }
    
    public func didTapAtCell(number: Int){
        guard let pokemons = self.favoritesPokemons,
              let favoriteVC = self.viewController else {return}
        let pokemon = pokemons[number]
        favoriteVC.presentPokemonInfoVC(VC: Builder.shared.createPokemonInfoVC(pokemon: pokemon))
    }
    
}
