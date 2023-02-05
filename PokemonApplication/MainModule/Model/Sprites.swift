//
//  Sprites.swift
//  Pokemon Application
//
//  Created by And Nik on 25.01.23.
//

import UIKit

struct Sprites: Codable{
    
    public let frontDefaultUrl: URL?
    
    public func getImage(url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url else{
            DispatchQueue.main.async {
                completion(UIImage(systemName: "questionmark.circle")!)
            }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print(error)
                    completion(UIImage(systemName: "questionmark.circle")!)
                    return
                }
                guard let data,
                      let image = UIImage(data: data) else {return}
                completion(image)
            }
        }.resume()
    }
    
    init(frontDefaultUrl: URL = URL(fileURLWithPath: "")) {
        self.frontDefaultUrl = frontDefaultUrl
    }
    
    private enum CodingKeys: String, CodingKey{
        case frontDefaultUrl = "front_default"
    }
    
}
