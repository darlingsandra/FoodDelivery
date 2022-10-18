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
    
    typealias Tab = (category: Category, button: CustomSegmentedButton)

    // MARK: - Properties
    var presenter: MenuPresenter!
    
    private var lastContentOffset: CGFloat = 0
    private var heightTopViewConstraint: NSLayoutConstraint!
    
    private let heightCell: CGFloat = 164
    private let heightCityButton: CGFloat = 20
    private let heightBannerView: CGFloat = 112
    private let heightCategoryButton: CGFloat = 32
    private let heightSpacing: CGFloat = 24
    
    private lazy var maxHeightTopView: CGFloat = {
        heightCityButton + heightBannerView + heightCategoryButton + 2 * heightSpacing
    }()
    private lazy var minHeightTopView: CGFloat = {
        heightCityButton + heightCategoryButton + heightSpacing
    }()
   
    private var categoryTab: Tab!
    private let tableView = UITableView()
            
    private lazy var cityButton: CityButton = {
        let button = CityButton()
        button.addTarget(self, action: #selector(cityButtonTapped(sender: )), for: .touchDown)
        return button
    }()
    private lazy var stackViewCity: UIStackView = {
         UIStackView(arrangedSubviews: [cityButton, UIView()])
    }()
    
    private lazy var bannerView: BannerView = BannerView(urls: ["Banner1", "Banner2"])
    
    private lazy var categoryBar: CustomSegmentedControl = {
        let customSegmentedControl = CustomSegmentedControl(items:  Category.allCases.map { $0.rawValue } )
        customSegmentedControl.addTarget(self, action: #selector(valueChangedTab(sender: )))
        categoryTab = (Category.allCases.first!, customSegmentedControl.tabs.first!)
        return customSegmentedControl
    }()
    
    private lazy var topView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewCity, bannerView, categoryBar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .customBackgroundGrey
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        presenter.getFoods()
        setupView()
    }
    
    @objc func valueChangedTab(sender: UIButton) {
        for (index, button) in categoryBar.tabs.enumerated() {
            button.isSelected = button == sender
            if button.isSelected {
                categoryTab = (Category.allCases[index], button)
                scrollToSection(to: categoryTab)
            }
        }
    }
    
    @objc func cityButtonTapped(sender: CityButton) {
        sender.isCollapsed = !sender.isCollapsed
    }
}

// MARK: - UIScrollViewDelegate
extension MenuViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topViewAnimated(scrollView)
        categoryTabChangedToScroll(scrollView)
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getCountCategory()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = false
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCountFoods(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identififer, for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        cell.tag = indexPath.row
        presenter.showFood(for: cell as MenuViewCellProtocol, indexPath: indexPath)
        return cell
    }
}

// MARK: - MenuViewProtocol
extension MenuViewController: MenuViewProtocol {
    func showData() {
        tableView.reloadData()
    }
}

// MARK: - Private method
private extension MenuViewController {
    func setupView() {
        view.backgroundColor = .customBackgroundGrey
        
        cityButton.configure(title: "Москва")
        view.addSubview(topView)
                
        tableView.layer.cornerRadius = 20
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        heightTopViewConstraint = topView.heightAnchor.constraint(equalToConstant: maxHeightTopView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightTopViewConstraint,
            
            cityButton.leadingAnchor.constraint(equalTo: stackViewCity.leadingAnchor, constant: 16),
            cityButton.heightAnchor.constraint(equalToConstant: heightCityButton),
            bannerView.heightAnchor.constraint(equalToConstant: heightBannerView),
            categoryBar.heightAnchor.constraint(equalToConstant: heightCategoryButton),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 24),
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
    
    func scrollToSection(to tab: Tab) {
        guard let section = presenter.getSection(tab.category),
              tableView.numberOfSections > section else { return }
        let indexPath: IndexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func topViewAnimated(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0  {
            heightTopViewConstraint.constant = self.minHeightTopView
            tableView.layer.cornerRadius = 0
            bannerView.isHidden = true
        }
        else {
            bannerView.isHidden = false
            tableView.layer.cornerRadius = 20
            heightTopViewConstraint.constant = self.maxHeightTopView
        }
    }
    
    func categoryTabChangedToScroll(_ scrollView: UIScrollView) {
        let visiableCells = tableView.visibleCells
        guard let cell =  visiableCells.first as? MenuTableViewCell, !(cell.category == categoryTab.category) else { return }
        let diffContentOffset = self.lastContentOffset - scrollView.contentOffset.y
        let diffIndexCategory = (Category.allCases.firstIndex(of: categoryTab.category) ?? 0)
            - (Category.allCases.firstIndex(of: cell.category) ?? 0)

        guard (diffContentOffset > 0 && diffIndexCategory > 0) || (diffContentOffset < 0 && diffIndexCategory < 0) else { return }
        for button in categoryBar.tabs {
            if button.titleLabel?.text == cell.category.rawValue {
                button.isSelected = true
                categoryTab = (cell.category, button)
            } else {
                button.isSelected = false
            }
        }
    }
}

