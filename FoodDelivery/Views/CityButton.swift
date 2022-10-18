//
//  CityButton.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 15.10.2022.
//

import UIKit

final class CityButton: UIButton {
    
    var isCollapsed: Bool {
        didSet {
            imageArrowAnimated()
        }
    }
    
    private var imageArrow = UIImageView()
    
    required init() {
        isCollapsed = true
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityButton {
    func configure(title: String) {
        imageArrow = UIImageView()
        imageArrow.image = UIImage(named: "ArrowBottom")
        imageArrow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageArrow)
        
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
            imageArrow.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            imageArrow.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
}

private extension CityButton {
    func imageArrowAnimated() {
        let angle = isCollapsed ? CGFloat.pi * 2 : -CGFloat.pi / 2
        UIView.animate(withDuration: 0.3) {
            let transform = CGAffineTransform.identity.rotated(by: angle)
            self.imageArrow.transform = transform
        }
    }
}
