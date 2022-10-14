//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    func showData()
}

final class MenuViewController: UIViewController {

    var presenter: MenuPresenter!
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        presenter.getFoods()
        setupView()
    }

}

extension MenuViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        164
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCountFoods()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identififer, for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        presenter.showFood(for: cell as MenuViewCellProtocol, indexPath: indexPath)
        return cell
    }
}

extension MenuViewController: MenuViewProtocol {
    func showData() {
        tableView.reloadData()
    }
}

private extension MenuViewController {
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func registerCell() {
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identififer)
    }
}

