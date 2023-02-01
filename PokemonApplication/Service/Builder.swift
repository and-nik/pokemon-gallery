//
//  Builder.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import Foundation

protocol BuilderProtocol {
    func createGalleryVC() -> GalleryViewController
    func createPokemonInfoVC(pokemon: Pokemon) -> PokemonInfoViewController
    func createSearchVC(results: [PokemonUrl]) -> SearchViewController
    func createFavoritesVC() -> FavoritesViewController
}

final class Builder: BuilderProtocol{
    
    static let shared = Builder()
    
    public func createGalleryVC() -> GalleryViewController {
        let galleryVC = GalleryViewController()
        let networkService = NetworkService()
        let dataHandlerService = DataHandlerService()
        galleryVC.presenter = GalleryPresenter(galleryViewController: galleryVC, networkService: networkService, dataHandlerService: dataHandlerService)
        return galleryVC
    }
    
    public func createPokemonInfoVC(pokemon: Pokemon) -> PokemonInfoViewController {
        let pokemonInfoVC = PokemonInfoViewController()
        let dataHandlerService = DataHandlerService()
        pokemonInfoVC.presenter = PokemonInfoPresenter(pokemonInfoViewController: pokemonInfoVC, pokemon: pokemon, datahandlerService: dataHandlerService)
        return pokemonInfoVC
    }
    
    public func createSearchVC(results: [PokemonUrl]) -> SearchViewController {
        let searchResultsVC = SearchViewController()
        let networkService = NetworkService()
        searchResultsVC.presenter = SearchPresenter(viewController: searchResultsVC, pokemonsUrls: [PokemonUrl](), networkService: networkService)
        return searchResultsVC
    }
    
    public func createFavoritesVC() -> FavoritesViewController {
        let favoritesVC = FavoritesViewController()
        let dataHandlerService = DataHandlerService()
        favoritesVC.presenter = FavoritesPresenter(viewController: favoritesVC, dataHandlerService: dataHandlerService)
        return favoritesVC
    }
    
}
