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
        case .pizza: return "all"
        case .pasta: return "android"
        case .burger: return "ios"
        case .desserts: return "design"
        case .drinks: return "management"
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
    let imageUrl: String?
}
