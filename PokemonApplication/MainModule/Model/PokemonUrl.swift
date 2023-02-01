//
//  Result.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import Foundation

struct PokemonUrl: Decodable{
    
    public let name: String
    public let url: URL
    
    init(name: String = String(), url: URL = URL(fileURLWithPath: "")) {
        self.name = name
        self.url = url
    }
}
