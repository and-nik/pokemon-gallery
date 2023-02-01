//
//  FavoritesViewController.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import UIKit

final class FavoritesViewController: UIViewController{
    
    //MARK: - public values
    
    public var presenter: FavoritesPresenterProtocol!
    
    //MARK: - private values
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchViewControllerTableViewCell.self, forCellReuseIdentifier: SearchViewControllerTableViewCell.reuseID)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    //MARK: - override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerConfig()
        self.navigationControllerConfig()
        self.addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.reloadData()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    //MARK: - functions
    
    private func controllerConfig(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func navigationControllerConfig(){
        self.navigationItem.title = "Favorites Pokemons"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews(){
        self.view.addSubview(self.tableView)
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol{
    
    public func presentPokemonInfoVC(VC: PokemonInfoViewController) {
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

extension FavoritesViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        70
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoritesPokemons = self.presenter.favoritesPokemons else {return 0}
        return favoritesPokemons.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: SearchViewControllerTableViewCell.reuseID, for: indexPath) as? SearchViewControllerTableViewCell,
              let favoritesPokemons = self.presenter.favoritesPokemons else {return UITableViewCell()}
        
        let favoritePokemon = favoritesPokemons[indexPath.item]
        cell.nameLabel.text = favoritePokemon.name
        cell.iconImageView.image = favoritePokemon.getImage()
        
        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate{
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didTapAtCell(number: indexPath.item)
    }
}
