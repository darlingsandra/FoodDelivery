//
//  DataMnager.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import  UIKit

enum ErrorLoad: Error {
    case invalidURL
    case noData
    case decodingError
}

enum API: String {
    case foodURL = "jsonfood"
}

final class DataManager {
    
    static let shared = DataManager()
        
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, complition: @escaping (Result<T, ErrorLoad>) -> Void) {
        guard let fileLocation = Bundle.main.url(forResource: url, withExtension: "json") else {
            complition(.failure(.invalidURL))
            return
        }
        
        guard let data = try? Data(contentsOf: fileLocation) else {
            complition(.failure(.noData))
            return
        }
                
        do {
            let decoder = JSONDecoder()
            let sections = try decoder.decode(T.self, from: data)
            complition(.success(sections))
        } catch let error {
            print(error)
            complition(.failure(.noData))
        }
    }
        
    func getFoodImage(for category: Category) -> String {
        switch category {
        case .pizza:
            return "https://foodish-api.herokuapp.com/images/pizza/pizza\(Int.random(in: 1...95)).jpg"
        case .pasta:
            return "https://foodish-api.herokuapp.com/images/pasta/pasta\(Int.random(in: 1...34)).jpg"
        case .burger:
            return "https://foodish-api.herokuapp.com/images/burger/burger\(Int.random(in: 1...87)).jpg"
        case .desserts:
            return "https://foodish-api.herokuapp.com/images/dessert/dessert\(Int.random(in: 1...36)).jpg"
        case .drinks:
            return "https://foodish-api.herokuapp.com/images/dosa/dosa\(Int.random(in: 1...83)).jpg"
        }
    }
}
