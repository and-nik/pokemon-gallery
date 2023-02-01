//
//  SearchViewControllerTableViewCell.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import UIKit

final class SearchViewControllerTableViewCell: UITableViewCell{
    
    //MARK: - values
    
    static let reuseID = "SearchViewControllerTableViewCell"
    
    private let containerView:UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        return containerView
    }()
    
    public let iconImageView:UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.shadowRadius = 5
        iconImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        iconImageView.layer.shadowOpacity = 0.5
        return iconImageView
    }()
    public let nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byWordWrapping
        return nameLabel
    }()
    
    //MARK: - inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - overrides functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = UIImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        let iconImageViewHeight:CGFloat = 100
        let iconImageViewWidth:CGFloat = 70
        NSLayoutConstraint.activate([
            self.iconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            self.iconImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewHeight),
            self.iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewWidth),
        ])
        
        let nameLabelHeight:CGFloat = 30
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 5),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ])
    }
    
    //MARK: - functions
    
    private func addSubviews(){
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.iconImageView)
        self.containerView.addSubview(self.nameLabel)
    }
}
