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
    
    private var curentTab: CustomSegmentedButton!
    
    private lazy var cityButton = CityButton()
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .customBackgroundGrey
        return topView
    }()
    
    private lazy var customSegmentedControl: CustomSegmentedControl = {
        let customSegmentedControl = CustomSegmentedControl(items:  Category.allCases.map { $0.rawValue } )
        customSegmentedControl.addTarget(self, action: #selector(valueChangedTab(sender: )))
        curentTab = customSegmentedControl.tabs.first
        return customSegmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        presenter.getFoods()
        setupView()
    }
    
    @objc func valueChangedTab(sender: UIButton) {
        for button in customSegmentedControl.tabs {
            button.isSelected = button == sender
            if button.isSelected {
                curentTab = button
            }
        }
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
        cityButton.configure(title: "Москва")
        topView.addSubview(cityButton)
        topView.addSubview(customSegmentedControl)
        view.addSubview(topView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 160),
            
            customSegmentedControl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -24),
            customSegmentedControl.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            customSegmentedControl.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            cityButton.bottomAnchor.constraint(equalTo: customSegmentedControl.topAnchor, constant: -24),
            cityButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            cityButton.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        setupShadows(for: topView)
    }
    
    func setupShadows(for view: UIView) {
        let shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.646, green: 0.646, blue: 0.646, alpha: 0.24).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 14
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center

        shadows.layer.addSublayer(layer0)

        let shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
    }
    
    func registerCell() {
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identififer)
    }
}

