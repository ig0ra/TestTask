//
//  QuoteTableViewCell.swift
//  Technical-test
//
//  Created by Ihor Obrizko on 12.04.2023.
//

import UIKit

final class QuoteTableViewCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var lastLabel = UILabel()
    var lastChangePercentLabel = UILabel()
    var currencyLabel = UILabel()
    var favoriteImageView = UIImageView()
    var variantColor: VariationColor? {
        didSet {
            lastChangePercentLabel.textColor = variantColor?.uiColor()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNameLabel()
        setupLastLabel()
        setupCurrencyLabel()
        setupQuoteFavoriteImageView()
        setupLastChangePercentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteImageView(isFavorite: Bool) {
        favoriteImageView.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
    }
}

private extension QuoteTableViewCell {
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    func setupLastLabel() {
        contentView.addSubview(lastLabel)
        lastLabel.translatesAutoresizingMaskIntoConstraints = false

        lastLabel.font = UIFont.boldSystemFont(ofSize: 16)
        lastLabel.textAlignment = .left
        lastLabel.font = .systemFont(ofSize: 16)
        lastLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            lastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            lastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    func setupCurrencyLabel() {
        contentView.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currencyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        currencyLabel.textAlignment = .left
        currencyLabel.font = .systemFont(ofSize: 16)
        currencyLabel.textColor = .black

        NSLayoutConstraint.activate([
            currencyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            currencyLabel.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: 3)
        ])
    }
    
    private func setupQuoteFavoriteImageView() {
        contentView.addSubview(favoriteImageView)
        
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupLastChangePercentLabel() {
        contentView.addSubview(lastChangePercentLabel)
        lastChangePercentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastChangePercentLabel.trailingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: -40),
            lastChangePercentLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

