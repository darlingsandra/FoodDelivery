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
    func getCountFoods(for section: Int) -> Int
    func showFood(for cell: MenuViewCellProtocol, indexPath: IndexPath)
}

final class MenuPresenter: MenuPresenterProtocol {
    
    private unowned let view: MenuViewProtocol
    private var categorys: [Category] = []
    private var foods: [Food] = [] {
        didSet {
            setCategory()
        }
    }
    
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
        categorys.count
    }
    
    func getCategory(_ indexPath: IndexPath) -> Category {
        categorys[indexPath.section]
    }
    
    func getSection(_ category: Category) -> Int? {
        self.categorys.firstIndex(of: category)
    }
    
    func getCountFoods(for section: Int) -> Int {
        foods.filter { $0.category == categorys[section] }.count
    }
    
    func showFood(for cell: MenuViewCellProtocol, indexPath: IndexPath) {
        let currentCategory = categorys[indexPath.section]
        let currentFoods = foods.filter { $0.category == currentCategory }
        let food = currentFoods[indexPath.row]
        cell.configure(
            category: food.category,
            title: food.title,
            description: food.description,
            price: "от \(food.price) р",
            imageUrl: food.imageUrl
        )
    }
}

private extension MenuPresenter {
    func setCategory() {
        Category.allCases.forEach { category in
            if foods.contains(where: { $0.category == category }), !categorys.contains(category)  {
                categorys.append(category)
            }
        }
    }
}
