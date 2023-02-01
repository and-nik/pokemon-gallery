//
//  PokemonType.swift
//  Pokemon Application
//
//  Created by And Nik on 25.01.23.
//

import Foundation

struct PokemonType: Codable{
    
    public let name: String
    
    init(name: String = "Unknowed") {
        self.name = name
    }
}
