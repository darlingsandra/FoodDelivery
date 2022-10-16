//
//  Food.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import Foundation

enum Category: String, CaseIterable  {
    case pizza = "Пицца"
    case pasta = "Паста"
    case burger = "Бургер"
    case desserts = "Дисерты"
    case drinks = "Напитки"
    
    var name: String {
        switch self {
        case .pizza: return "pizza"
        case .pasta: return "pasta"
        case .burger: return "burger"
        case .desserts: return "desserts"
        case .drinks: return "drinks"
        }
    }
}

struct ListFood: Decodable {
    let foods: [Food]
}

struct Food: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Int
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, category, price, imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Int.self, forKey: .price)
        
        let category = try container.decode(String.self, forKey: .category)
        self.category = category
        self.imageUrl = ""
        
        let currentCategorys = Category.allCases.filter { $0.name == category }
        
        guard !currentCategorys.isEmpty, let currentCategory = currentCategorys.first else { return }
        self.imageUrl = DataManager.shared.getFoodImage(for: currentCategory)
    }
}
