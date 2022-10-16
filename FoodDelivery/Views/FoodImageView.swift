//
//  FoodImageView.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 15.10.2022.
//

import Foundation

import UIKit

final class FoodImageView: UIImageView {
        
    // MARK: - Initializers
    init(size: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderShape()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupBorderShape() {
        let width = bounds.size.width
        layer.cornerRadius = width / 2
    }
}
