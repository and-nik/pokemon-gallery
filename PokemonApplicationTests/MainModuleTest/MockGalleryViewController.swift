//
//  MockGalleryViewController.swift
//  PokemonApplicationTests
//
//  Created by And Nik on 01.02.23.
//

import Foundation
@testable import PokemonApplication

final class MockGalleryViewController: GalleryViewControllerProtocol{
    
    func failureInternetConnection() {
        print("failureInternetConnection")
    }
    
    func successInternetConnection() {
        print("successInternetConnection")
    }
    
    func presentPokemonInfoVC(VC: PokemonApplication.PokemonInfoViewController) {
        print("presentPokemonInfoVC")
    }
    
    func searchResult(pokemonsUrls: [PokemonApplication.PokemonUrl]) {
        print("searchResult")
    }
    
}
