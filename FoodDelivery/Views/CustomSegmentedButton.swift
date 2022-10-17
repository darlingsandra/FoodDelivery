//
//  CustomSegmentedButton.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 15.10.2022.
//

import UIKit

final class CustomSegmentedButton: UIButton {
        
    override var isSelected: Bool {
        didSet {
            setSelectedView()
        }
    }
    
    private let paddingSide = 23.0
    
    required init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomSegmentedButton {
        
    func configure(title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 13
        layer.borderWidth = 1
        layer.borderColor = UIColor.customRed.withAlphaComponent(0.4).cgColor
        
        let attributedFontNormal = UIFont(name: "SFUIDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        let attributedTextNormal = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: attributedFontNormal,
                         NSAttributedString.Key.foregroundColor: UIColor.customRed.withAlphaComponent(0.4)]
        )
        
        let attributedFontSelected = UIFont(name: "SFUIDisplay-Bold", size: 13) ?? .systemFont(ofSize: 13)
        let attributedTextSelected = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: attributedFontSelected,
                         NSAttributedString.Key.foregroundColor: UIColor.customRed]
        )
         
        setAttributedTitle(attributedTextNormal, for: .normal)
        setAttributedTitle(attributedTextSelected, for: .selected)
           
        configureButtonConstraints()
    }
        
    func configureButtonConstraints() {
        guard let labelWidth = titleLabel?.frame.width else { return }
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: labelWidth + 10 + paddingSide * 2).isActive = true
    }
    
    func setSelectedView() {
        if isSelected {
            self.layer.backgroundColor =  UIColor.customRed.withAlphaComponent(0.2).cgColor
            self.layer.borderWidth = 0
        } else {
            self.layer.backgroundColor =  UIColor.customBackgroundGrey.cgColor
            self.layer.borderWidth = 1
        }
    }
}
