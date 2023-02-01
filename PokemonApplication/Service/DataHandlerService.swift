//
//  DataHandleService.swift
//  Pokemon Application
//
//  Created by And Nik on 25.01.23.
//

import UIKit

enum DataHandlerServiceKeys: String{
    case favoritesPokemons = "favoritesPokemons"
}

protocol DataHandlerServiceProtocol{
    func loadData() -> [Pokemon]
    func saveData(pokemons: [Pokemon])
}

final class DataHandlerService: DataHandlerServiceProtocol{
    
    private let userDefaults = UserDefaults.standard
    
    public func loadData() -> [Pokemon] {
        guard let data = self.userDefaults.object(forKey: DataHandlerServiceKeys.favoritesPokemons.rawValue) as? Data else {return []}
        guard let pokemons = try? JSONDecoder().decode([Pokemon].self, from: data) else {return []}
        return pokemons
    }
    
    public func saveData(pokemons: [Pokemon]) {
        guard let data = try? JSONEncoder().encode(pokemons) else {return}
        self.userDefaults.set(data, forKey: DataHandlerServiceKeys.favoritesPokemons.rawValue)
    }
    
}
