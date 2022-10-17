//
//  BannerView.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 16.10.2022.
//

import UIKit
import SDWebImage

final class BannerView: UIScrollView {

    var items: [UIImageView] = []
    
    required init(urls: [String]) {
        super.init(frame: .zero)
        configure(urls: urls)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BannerView {
    
    func configure(urls: [String]) {
        items = urls.map { url in
            let imageView = UIImageView()
            imageView.image = UIImage(named: url)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 112),
                imageView.widthAnchor.constraint(equalToConstant: 300)
            ])
            return imageView
        }
                        
        let stackView = UIStackView(arrangedSubviews: items)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        addSubview(stackView)
                
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        guard let fistTab = items.first, let lastTab = items.last else { return }
        
        NSLayoutConstraint.activate([
            fistTab.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            lastTab.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
        ])
    }
}
