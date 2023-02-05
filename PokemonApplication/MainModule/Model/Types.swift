//
//  Types.swift
//  Pokemon Application
//
//  Created by And Nik on 25.01.23.
//

import Foundation

struct Types: Codable{
    
    public let type: PokemonType
    
    init(type: PokemonType) {
        self.type = type
    }
}
