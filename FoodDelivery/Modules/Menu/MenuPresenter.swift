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
    func getCountFoods() -> Int
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
    
    func getCountFoods() -> Int {
        foods.count
    }
    
    func showFood(for cell: MenuViewCellProtocol, indexPath: IndexPath) {
        let food = foods[indexPath.row]
        cell.configure(
            title: food.title,
            description: food.description,
            price: "от \(food.price) р"
        )
    }
}
