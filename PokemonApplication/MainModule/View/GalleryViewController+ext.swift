//
//  ViewController.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit

final class GalleryViewController: UIViewController {
    
    //MARK: - public values
    
    public var presenter: GalleryPresenterProtocol!
    
    //MARK: - private values
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = self.createCompositionalLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return collectionView
    }()
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: Builder.shared.createSearchVC(results: [PokemonUrl]()))
        searchController.searchBar.placeholder = "Search pokemon"
        searchController.searchResultsUpdater = self
        searchController.showsSearchResultsController = true//show result controller content even searchBar.text is empty
        searchController.searchBar.tintColor = .tintColor
        return searchController
    }()
    private lazy var tryAgainButton: UIButton = {
        let tryAgainButton = UIButton(type: .system)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.addTarget(self, action: #selector(handleTryAgain), for: .touchUpInside)
        tryAgainButton.layer.shadowRadius = 5
        tryAgainButton.layer.shadowOpacity = 0.2
        tryAgainButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        tryAgainButton.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        return tryAgainButton
    }()
    private lazy var scrollToTopButton: UIButton = {
        let scrollToTopButton = UIButton(type: .system)
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false
        scrollToTopButton.imageView?.contentMode = .scaleAspectFill
        scrollToTopButton.addTarget(self, action: #selector(handleScrollToTop), for: .touchUpInside)
        scrollToTopButton.backgroundColor = .secondarySystemBackground
        scrollToTopButton.layer.shadowRadius = 10
        scrollToTopButton.layer.shadowOpacity = 0.5
        scrollToTopButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        scrollToTopButton.setImage(UIImage(systemName: "arrow.up.to.line.compact"), for: .normal)
        scrollToTopButton.alpha = 0
        return scrollToTopButton
    }()
    
    //MARK: - override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationControllerConfig()
        self.controllerConfig()
        self.addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollToTopButtonObserver()
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let tryAgainButtonHeight:CGFloat = 60
        let tryAgainButtonWidth:CGFloat = 60
        NSLayoutConstraint.activate([
            self.tryAgainButton.heightAnchor.constraint(equalToConstant: tryAgainButtonHeight),
            self.tryAgainButton.widthAnchor.constraint(equalToConstant: tryAgainButtonWidth),
            self.tryAgainButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            self.tryAgainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
        ])
        
        let scrollToTopButtonHeight:CGFloat = 45
        let scrollToTopButtonWidth:CGFloat = 45
        NSLayoutConstraint.activate([
            self.scrollToTopButton.heightAnchor.constraint(equalToConstant: scrollToTopButtonHeight),
            self.scrollToTopButton.widthAnchor.constraint(equalToConstant: scrollToTopButtonWidth),
            self.scrollToTopButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            self.scrollToTopButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
        ])
        
        self.scrollToTopButton.layer.cornerRadius = self.scrollToTopButton.bounds.height/2
    }

    //MARK: - functions
    
    private func controllerConfig(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func navigationControllerConfig(){
        self.navigationItem.title = "Pokemons Gallery"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.searchController
    }
    
    private func addSubviews(){
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.tryAgainButton)
        self.view.addSubview(self.scrollToTopButton)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5)), subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.interGroupSpacing = 0
            return section
        }
    }
    
    private func scrollToTopButtonObserver(){
        if self.collectionView.contentOffset.y > 200 && self.collectionView.isHidden == false {
            UIView.animate(withDuration: 0.5) {
                self.scrollToTopButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.scrollToTopButton.alpha = 0
            }
        }
    }
    
    @objc private func handleTryAgain(){
        self.presenter.getPokemonsUrls()
    }
    
    @objc private func handleScrollToTop(){
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: false)
    }
    
}

extension GalleryViewController: GalleryViewControllerProtocol{
    
    public func searchResult(pokemonsUrls: [PokemonUrl]) {
        guard let searchResultsVC = self.searchController.searchResultsController as? SearchViewController else {return}
        let networkService = NetworkService()
        searchResultsVC.presenter = SearchPresenter(viewController: searchResultsVC, pokemonsUrls: pokemonsUrls, networkService: networkService)
        searchResultsVC.tableView.reloadData()
    }
    
    public func failureInternetConnection() {
        self.tryAgainButton.isHidden = false
        self.collectionView.isHidden = true
        self.scrollToTopButtonObserver()
    }
    
    public func successInternetConnection() {
        self.tryAgainButton.isHidden = true
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        self.scrollToTopButtonObserver()
    }
    
    public func presentPokemonInfoVC(VC: PokemonInfoViewController){
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension GalleryViewController: UISearchResultsUpdating{
    
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchController.searchBar.text else {return}
        self.presenter.didPrintInSearchBar(text: text)
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let pokemonsUrls = self.presenter.pokemonsUrls else {return 0}
        return pokemonsUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseID, for: indexPath) as? GalleryCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? GalleryCollectionViewCell else {return}
        cell.activityIndicatorView.startAnimating()
        
        self.presenter.getPokemon(whith: indexPath.item) { pokemon, imageData in
            cell.imageView.image = UIImage(data: imageData)
            cell.nameLabel.text = pokemon.name
            if self.presenter.isPokemonFavorite(pokemon: pokemon){
                cell.favoriteImageView.isHidden = false
            } else {
                cell.favoriteImageView.isHidden = true
            }
            cell.activityIndicatorView.stopAnimating()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollToTopButtonObserver()
    }
    
}

extension GalleryViewController: UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didTapAtCell(number: indexPath.item)
    }
}
