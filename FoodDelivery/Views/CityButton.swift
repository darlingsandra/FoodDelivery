//
//  CityButton.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 15.10.2022.
//

import UIKit

final class CityButton: UIButton {
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityButton {
    func configure(title: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ArrowBottom")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        let attributedFontNormal = UIFont(name: "SFUIDisplay-Medium", size: 17) ?? .systemFont(ofSize: 17)
        let attributedTextNormal = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: attributedFontNormal,
                         NSAttributedString.Key.foregroundColor: UIColor.customBlack]
        )
        setAttributedTitle(attributedTextNormal, for: .normal)
        
        guard let titleLabel = self.titleLabel else { return }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
}
