//
//  MenuPresenter.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import Foundation

protocol MenuPresenterProtocol {
    init(view: MenuViewProtocol)
    func getFoods()
    func getCountFoods(for category: Category) -> Int
    func showFood(for cell: MenuViewCellProtocol, indexPath: IndexPath)
}

final class MenuPresenter: MenuPresenterProtocol {
    
    private unowned let view: MenuViewProtocol
    private var foods: [Food] = []
    
    init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func getFoods() {
        DataManager.shared.fetch(
            dataType: ListFood.self,
            url: API.foodURL.rawValue) { [weak self] result in
            switch result {
            case .success(let listFood):
                self?.foods = listFood.foods
                self?.view.showData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCountCategory() -> Int {
        Set(foods.map { $0.category }).count
    }
    
    func getCountFoods(for category: Category) -> Int {
        foods.filter { $0.category == category.name }.count
    }
    
    func showFood(for cell: MenuViewCellProtocol, indexPath: IndexPath) {
        let currentCategory = Category.allCases[indexPath.section]
        let currentFoods = foods.filter { $0.category == currentCategory.name }
        let food = currentFoods[indexPath.row]
        cell.configure(
            title: food.title,
            description: food.description,
            price: "от \(food.price) р",
            imageUrl: food.imageUrl
        )
    }
}
