//
//  Food.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import Foundation

enum Category {
    case pizza
    case pasta
    case burger
    case desserts
    case drinks
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
