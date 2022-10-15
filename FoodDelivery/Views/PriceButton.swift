//
//  PriceButton.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit

final class PriceButton: UIButton {
        
    override var isHighlighted: Bool {
        didSet {
            setAnimateTouch()
        }
    }

    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 87, height: 32))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PriceButton {
    func configure(title: String) {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.customRed.cgColor
        
        let attributedFontNormal = UIFont(name: "SFUIDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        let attributedTextNormal = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: attributedFontNormal,
                         NSAttributedString.Key.foregroundColor: UIColor.customRed]
        )
        
        let attributedFontSelected = UIFont(name: "SFUIDisplay-Bold", size: 13) ?? .systemFont(ofSize: 13)
        let attributedTextSelected = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: attributedFontSelected,
                         NSAttributedString.Key.foregroundColor: UIColor.customRed]
        )
         
        setAttributedTitle(attributedTextNormal, for: .normal)
        setAttributedTitle(attributedTextSelected, for: .highlighted)
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 32),
            widthAnchor.constraint(equalToConstant: 87),
        ])
    }
}

private extension PriceButton {
    func setAnimateTouch() {
        if isHighlighted {
            UIView.animate(withDuration: 0.6) {
                self.layer.backgroundColor =  UIColor.customRed.withAlphaComponent(0.2).cgColor
                self.layer.borderWidth = 0
            }
        } else {
            UIView.animate(withDuration: 0.6) {
                self.layer.backgroundColor =  UIColor.white.cgColor
                self.layer.borderWidth = 1
            }
        }
    }
}
