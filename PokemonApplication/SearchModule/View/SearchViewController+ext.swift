//
//  SearchViewController.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import UIKit

final class SearchViewController: UIViewController{
    
    //MARK: - public values
    
    public var presenter: SearchPresenterProtocol!

    public lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchViewControllerTableViewCell.self, forCellReuseIdentifier: SearchViewControllerTableViewCell.reuseID)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 350, right: 0)
        return tableView
    }()
    
    //MARK: - override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerConfig()
        self.addSubviews()
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
    
    private func addSubviews(){
        self.view.addSubview(self.tableView)
    }
}

extension SearchViewController: SearchViewControllerProtocol{
    
    public func presentPokemonInfoVC(VC: PokemonInfoViewController) {
        self.present(VC, animated: true)
    }
    
}

extension SearchViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        70
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemonsUrls = self.presenter.pokemonsUrls else {return 0}
        return pokemonsUrls.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: SearchViewControllerTableViewCell.reuseID, for: indexPath) as? SearchViewControllerTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SearchViewControllerTableViewCell else {return}
        self.presenter.getPokemon(whith: indexPath.item) { pokemon, imageData in
            cell.iconImageView.image = UIImage(data: imageData)
            cell.nameLabel.text = pokemon.name
        }
    }
}

extension SearchViewController: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didTapAtCell(number: indexPath.item)
    }
    
}
