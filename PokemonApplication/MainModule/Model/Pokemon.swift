//
//  Pokemon.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit.UIImage

struct Pokemon: Codable{
    
    public let name: String
    public let sprites: Sprites
    public let types: [Types]
    public let weight: Int
    public let height: Int
    public var imageData: Data?
    
    init(name: String = "Unknowed", sprites: Sprites = Sprites(), types: [Types] = [Types](), weight: Int = 0, height: Int = 0) {
        self.name = name
        self.sprites = sprites
        self.types = types
        self.weight = weight
        self.height = height
    }
    
    public func getImage() -> UIImage{
        guard let data = self.imageData,
              let image = UIImage(data: data) else {return UIImage()}
        return image
    }
}

