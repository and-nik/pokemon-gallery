//
//  GalleryCollectionViewCell.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell{
    
    //MARK: - values
    
    static let reuseID = "GalleryCollectionViewCell"
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowOpacity = 0.3
        return containerView
    }()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.5
        imageView.image = UIImage()
        return imageView
    }()
    public let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byWordWrapping
        return nameLabel
    }()
    public let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.tintColor = .tintColor
        activityIndicatorView.layer.shadowRadius = 5
        activityIndicatorView.layer.shadowOffset = CGSize(width: 3, height: 3)
        activityIndicatorView.layer.shadowOpacity = 0.5
        return activityIndicatorView
    }()
    public let favoriteImageView: UIImageView = {
        let favoriteImageView = UIImageView()
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.contentMode = .scaleAspectFill
        favoriteImageView.image = UIImage(systemName: "star.fill")
        favoriteImageView.tintColor = .systemYellow
        favoriteImageView.layer.shadowRadius = 5
        favoriteImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        favoriteImageView.layer.shadowOpacity = 0.2
        favoriteImageView.isHidden = true
        return favoriteImageView
    }()
    
    //MARK: - inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - overrides functions
    
    override func prepareForReuse() {//this func need to correct displaying image view(thet load from internet pokemons API) in collection view cell
        super.prepareForReuse()
        self.imageView.image = UIImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            self.imageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.imageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            self.imageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5),
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10),
        ])
        
        let activityIndicatorViewWidth:CGFloat = 40
        let activityIndicatorViewHeight:CGFloat = 40
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 0),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor, constant: 0),
            self.activityIndicatorView.widthAnchor.constraint(equalToConstant: activityIndicatorViewWidth),
            self.activityIndicatorView.heightAnchor.constraint(equalToConstant: activityIndicatorViewHeight)
        ])
        
        let favoriteImageViewWidth:CGFloat = 25
        let favoriteImageViewHeight:CGFloat = 25
        NSLayoutConstraint.activate([
            self.favoriteImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15),
            self.favoriteImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
            self.favoriteImageView.heightAnchor.constraint(equalToConstant: favoriteImageViewWidth),
            self.favoriteImageView.widthAnchor.constraint(equalToConstant: favoriteImageViewHeight)
        ])
    }
    
    //MARK: - functions
    
    private func addSubviews(){
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.imageView)
        self.containerView.addSubview(self.nameLabel)
        self.containerView.addSubview(self.activityIndicatorView)
        self.containerView.addSubview(self.favoriteImageView)
    }
}
