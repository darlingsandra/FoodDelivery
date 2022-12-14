//
//  MenuTableViewCell.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit
import SDWebImage


protocol MenuViewCellProtocol: AnyObject {
    func configure(category: Category, title: String, description: String, price: String, imageUrl: String)
}

class MenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identififer = "MenuTableViewCell"
    
    var category: Category!
    
    private let sizeImage: CGFloat = 132
    private lazy var foodImage = FoodImageView(size: sizeImage)
    
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
        
    // MARK: - init
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - MenuViewCellProtocol
extension MenuTableViewCell: MenuViewCellProtocol {
    func configure(category: Category, title: String, description: String, price: String, imageUrl: String) {
        
        self.category = category
        
        titleLabel.text = title
        descriptionLabel.text = description
        priceButton.configure(title: price)
        
        foodImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        foodImage.sd_setImage(with: URL(string: imageUrl)) { image, error, _, _ in
            self.foodImage.image = error == nil ? image : UIImage(named: "Food")
        }
    }
}

// MARK: - Private method
private extension MenuTableViewCell {
    func setupView() {
        contentView.addSubview(stackView)
        selectionStyle = .none
        
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
