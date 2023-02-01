//
//  PokemonInfoViewController.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit

final class PokemonInfoViewController: UIViewController{
    
    //MARK: - values
    
    public var presenter: PokemonInfoPresenterProtocol!
    
    //MARK: - private values
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.7
        return imageView
    }()
    private let pokemonDescriptionLabel: UILabel = {
        let pokemonDescriptionLabel = UILabel()
        pokemonDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonDescriptionLabel.numberOfLines = 4
        pokemonDescriptionLabel.font = .systemFont(ofSize: 18)
        pokemonDescriptionLabel.textAlignment = .left
        pokemonDescriptionLabel.lineBreakMode = .byWordWrapping
        return pokemonDescriptionLabel
    }()
    private lazy var favoritesButton:UIButton = {
        let favoritesButton = UIButton(type: .system)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.addTarget(self, action: #selector(handleFavorites), for: .touchUpInside)
        favoritesButton.layer.shadowRadius = 5
        favoritesButton.layer.shadowOpacity = 0.2
        favoritesButton.layer.shadowOffset = CGSize(width: 10, height: 10)
        favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoritesButton.imageView?.contentMode = .scaleAspectFill
        return favoritesButton
    }()
    
    //MARK: - override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerConfig()
        self.navigationControllerConfig()
        self.addSubviews()

        self.presenter.readyToSetPokemon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.presenter.isPokemonFavorite(){
            self.favoritesButton.tintColor = .systemYellow
        } else {
            self.favoritesButton.tintColor = .systemGray3
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
        ])
        
        let pokemonDescriptionLabelHeight:CGFloat = 130
        NSLayoutConstraint.activate([
            self.pokemonDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.pokemonDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.pokemonDescriptionLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 50),
            self.pokemonDescriptionLabel.heightAnchor.constraint(equalToConstant: pokemonDescriptionLabelHeight)
        ])
        
        let favoritesButtonHeight:CGFloat = 30
        let favoritesButtonWidth:CGFloat = 30
        NSLayoutConstraint.activate([
            self.favoritesButton.heightAnchor.constraint(equalToConstant: favoritesButtonHeight),
            self.favoritesButton.widthAnchor.constraint(equalToConstant: favoritesButtonWidth),
            self.favoritesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.favoritesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    //MARK: - functions

    private func controllerConfig(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func navigationControllerConfig(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews(){
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.pokemonDescriptionLabel)
        self.view.addSubview(self.favoritesButton)
    }
    
    @objc private func handleFavorites(){
        self.presenter.didTabAtFavoriteButton()
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewControllerProtocol{
    
    public func setPokemon(pokemon: Pokemon) {
        self.navigationItem.title = pokemon.name.uppercased()
        
        if pokemon.imageData == nil{
            let imageUrl = pokemon.sprites.frontDefaultUrl
            pokemon.sprites.getImage(url: imageUrl) { image in
                self.imageView.image = image
            }
        } else {
            self.imageView.image = pokemon.getImage()
        }
        
        var types = String()
        for type in pokemon.types{
            types += type.type.name + " "
        }
        
        self.pokemonDescriptionLabel.text = "full name: \(pokemon.name)\n" + "type(s): " + types + "\n" + "weight: \(pokemon.weight)\n" + "height: \(pokemon.height)"
    }
    
}

