//
//  CustomSegmentedControl.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 15.10.2022.
//

import UIKit

final class CustomSegmentedControl: UIScrollView {

    var tabs: [CustomSegmentedButton] = []
    
    required init(items: [String]) {
        super.init(frame: .zero)
        configure(items: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector) {
        tabs.forEach { $0.addTarget(target, action: action, for: .touchUpInside) }
    }
}

private extension CustomSegmentedControl {
    
    func configure(items: [String]) {
        tabs = items.map { CustomSegmentedButton(title: $0) }
                        
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        addSubview(stackView)
                
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        guard let fistTab = tabs.first, let lastTab = tabs.last else { return }
        fistTab.isSelected = true
        
        NSLayoutConstraint.activate([
            fistTab.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            lastTab.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
        ])
    }
}
