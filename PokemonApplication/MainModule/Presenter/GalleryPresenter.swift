//
//  MainPresenter.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import Foundation

protocol GalleryViewControllerProtocol: AnyObject{

    func failureInternetConnection()
    func successInternetConnection()
    func presentPokemonInfoVC(VC: PokemonInfoViewController)
    func searchResult(pokemonsUrls: [PokemonUrl])
}

protocol GalleryPresenterProtocol: AnyObject{
    
    var pokemonsUrls: [PokemonUrl]? {get set}
    
    init(galleryViewController: GalleryViewControllerProtocol, networkService: NetworkServiceProtocol, dataHandlerService: DataHandlerServiceProtocol)
    
    func getPokemonsUrls()
    func getPokemon(whith number: Int, completion: @escaping (Pokemon, Data) -> Void)
    func didTapAtCell(number: Int)
    func didPrintInSearchBar(text: String)
    func isPokemonFavorite(pokemon: Pokemon) -> Bool
}

final class GalleryPresenter: GalleryPresenterProtocol {
    
    public var pokemonsUrls: [PokemonUrl]?
    
    private weak var galleryViewController: GalleryViewControllerProtocol?
    private let networkService: NetworkServiceProtocol!
    private let dataHandlerService: DataHandlerServiceProtocol!

    required init(galleryViewController: GalleryViewControllerProtocol, networkService: NetworkServiceProtocol, dataHandlerService: DataHandlerServiceProtocol) {
        self.galleryViewController = galleryViewController
        self.networkService = networkService
        self.dataHandlerService = dataHandlerService
        self.getPokemonsUrls()
    }
    
    public func getPokemonsUrls(){
        self.networkService.getPokemonsUrlsFromNetwork { [weak self] pokemonsUrlsResult in
            guard let self,
                  let galleryVC = self.galleryViewController else {return}
            
            DispatchQueue.main.async {//переводин на главный поток чтобы UI в galleryViewController не сломался
                if pokemonsUrlsResult == nil {
                    galleryVC.failureInternetConnection()
                }
                else{
                    self.pokemonsUrls = pokemonsUrlsResult
                    galleryVC.successInternetConnection()
                }
            }
        }
    }
    
    public func didTapAtCell(number: Int){
        guard let pokemonsUrls = self.pokemonsUrls,
              let galleryVC = self.galleryViewController else {return}
        
        self.networkService.getPokemonFromUrl(pokemonsUrls: pokemonsUrls, number: number) { pokemon in
            DispatchQueue.main.async {
                guard let pokemon else {
                    galleryVC.failureInternetConnection()
                    return
                }
                galleryVC.successInternetConnection()
                galleryVC.presentPokemonInfoVC(VC: Builder.shared.createPokemonInfoVC(pokemon: pokemon))
            }
        }
    }
    
    public func didPrintInSearchBar(text: String) {
        guard let galleryVC = self.galleryViewController,
              let pokemonsUrls = self.pokemonsUrls else {return}
        
        if text == "" {
            galleryVC.searchResult(pokemonsUrls: pokemonsUrls)
        } else {
            let filteredResults = pokemonsUrls.filter { $0.name.lowercased().contains(text.lowercased()) }
            galleryVC.searchResult(pokemonsUrls: filteredResults)
        }
    }
    
    public func isPokemonFavorite(pokemon: Pokemon) -> Bool {
        let pokemons = self.dataHandlerService.loadData()
        
        return pokemons.contains(where: { favoritePokemon in
            favoritePokemon.name == pokemon.name
        })
    }
    
    public func getPokemon(whith number: Int, completion: @escaping (Pokemon, Data) -> Void){
        guard let pokemonsUrls = self.pokemonsUrls else {return}
        
        self.networkService.getPokemonFromUrl(pokemonsUrls: pokemonsUrls, number: number) { pokemon in
            guard let pokemon else {
                //self.galleryViewController?.failureInternetConnection()
                return
            }
            pokemon.sprites.getImage(url: pokemon.sprites.frontDefaultUrl) { image in
                guard let imageData = image.pngData() else {return}
                completion(pokemon, imageData)
            }
        }
    }
}
