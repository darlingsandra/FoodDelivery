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
    
    private var imageCache = NSCache<NSString, UIImage>()
    
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
    
    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(UIImage(named: "Goose"))
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(UIImage(named: "Goose"))
                }
                return
            }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
