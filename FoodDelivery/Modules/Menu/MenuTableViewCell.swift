//
//  MenuTableViewCell.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit


protocol MenuViewCellProtocol: AnyObject {
    func configure(title: String, description: String, price: String)
}

class MenuTableViewCell: UITableViewCell {

    static let identififer = "MenuTableViewCell"
    
    private let sizeImage: CGFloat = 132
    
    private lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Food")
        imageView.layer.cornerRadius = 10
        imageView.frame = CGRect(x: 0, y: 0, width: sizeImage, height: sizeImage)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Semibold", size: 17)
        label.textColor = .customDarkGrey
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textRect(forBounds: label.bounds, limitedToNumberOfLines: 1)
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        label.textColor = .customLightGrey
        label.numberOfLines = 0
        label.contentMode = .topLeft
        return label
    }()
    
    private lazy var priceButton: PriceButton = {
        let button = PriceButton()
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), priceButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let rightStackView = UIStackView(arrangedSubviews: [infoStackView, priceStackView, UIView()])
        rightStackView.axis = .vertical
        rightStackView.spacing = 8
        
        let stackView = UIStackView(arrangedSubviews: [foodImage, rightStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
        
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuTableViewCell: MenuViewCellProtocol {
    func configure(title: String, description: String, price: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        priceButton.configure(title: price)
    }
}

extension MenuTableViewCell {
    func setupView() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            foodImage.heightAnchor.constraint(equalToConstant: sizeImage),
            foodImage.widthAnchor.constraint(equalToConstant: sizeImage),
        ])
    }
}
