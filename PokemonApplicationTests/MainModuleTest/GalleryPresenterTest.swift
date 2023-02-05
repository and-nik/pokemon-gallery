//
//  GalleryPresenterTest.swift
//  PokemonApplicationTests
//
//  Created by And Nik on 01.02.23.
//

import XCTest
@testable import PokemonApplication

final class GalleryPresenterTest: XCTestCase {

    var mockGalleryViewController: MockGalleryViewController!
    var galleryPresenter: GalleryPresenter!
    var mockNetworkService: NetworkServiceProtocol!
    var mockDataHandlerService: DataHandlerServiceProtocol!
    
    override func tearDown() {
        mockGalleryViewController = nil
        galleryPresenter = nil
        mockNetworkService = nil
        mockDataHandlerService = nil
    }
    
    func testGetPokemonsUrls(){
        var pokemonsUrls = [PokemonUrl]()
        
        let pokemonUrl = PokemonUrl(name: "pokemon", url: URL(fileURLWithPath: ""))

        self.mockGalleryViewController = MockGalleryViewController()
        self.mockNetworkService = MockNetworkService(pokemonsUrls: [pokemonUrl], pokemonUrl: pokemonUrl)
        self.mockDataHandlerService = MockDataHandlerService()
        
        self.galleryPresenter = GalleryPresenter(galleryViewController: self.mockGalleryViewController, networkService: self.mockNetworkService, dataHandlerService: self.mockDataHandlerService)
        
        self.mockNetworkService.getPokemonsUrlsFromNetwork(){ newPokemonsUrls in
            guard let newPokemonsUrls else {
                self.mockGalleryViewController.failureInternetConnection()
                return
            }
            pokemonsUrls = newPokemonsUrls
            self.mockGalleryViewController.successInternetConnection()
        }
        XCTAssertNotEqual(pokemonsUrls.count, 0)
    }

    func testGetPokemon(){
        var pokemon = Pokemon()
        
        let pokemonsUrls = [PokemonUrl]()
        let pokemonUrl = PokemonUrl(name: "pokemon", url: URL(fileURLWithPath: ""))

        self.mockGalleryViewController = MockGalleryViewController()
        self.mockNetworkService = MockNetworkService(pokemonsUrls: [pokemonUrl], pokemonUrl: pokemonUrl)
        self.mockDataHandlerService = MockDataHandlerService()
        
        self.galleryPresenter = GalleryPresenter(galleryViewController: self.mockGalleryViewController, networkService: self.mockNetworkService, dataHandlerService: self.mockDataHandlerService)
        
        self.mockNetworkService.getPokemonFromUrl(pokemonsUrls: pokemonsUrls, number: 1) { newPokemon in
            guard let newPokemon else {return}
            pokemon = newPokemon
        }
        XCTAssertNotEqual(pokemon.name, "")
    }
    
    
    
}
