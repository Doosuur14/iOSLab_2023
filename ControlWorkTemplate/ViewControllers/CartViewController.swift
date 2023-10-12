//
//  MycartTableViewController.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate {
    
    enum TableSection {
        case main
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseidentifier)
        return table
    }()
    private lazy var removeFromcartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove from cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var totalCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cart = Cart()
    
    
    private var dataSource: UITableViewDiffableDataSource<TableSection, Car>?
    var dataSourceSnapshot: NSDiffableDataSourceSnapshot<TableSection, Car>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(totalCostLabel)
        setupLayout()
        setupDataSource()
    }
    
    func updateUI() {
        
        var Snapshot = NSDiffableDataSourceSnapshot<TableSection, Car>()
        Snapshot.appendSections([.main])
        Snapshot.appendItems(cart.items, toSection: .main)
        
        // Apply the snapshot to the data source
       let dataSource = tableView.dataSource as! UITableViewDiffableDataSource<TableSection,Car>
        dataSource.apply(dataSourceSnapshot!, animatingDifferences: true)
        
        // 2. Calculate the total cost using cart.getTotalCost()
        let totalCost = cart.getTotalCost()
        
        // 3. Update the total cost label
        totalCostLabel.text = "Total Cost: $\(totalCost)"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, IndexPath, car in
            let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseidentifier, for: IndexPath) as! CartTableViewCell
            cell.titleLabel.text = car.carModel
            cell.priceLabel.text = car.carprice
            cell.carImageView.image = car.carImage
            
            return cell
            
        })
        updateUI()
    }
    
    func applySnapshot(cars: [Car], animatingDifferences: Bool = true) {
        var newSnapshot = NSDiffableDataSourceSnapshot<TableSection,Car>()
        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(cars, toSection: .main)
        dataSourceSnapshot = newSnapshot
        dataSource?.apply(dataSourceSnapshot!, animatingDifferences: animatingDifferences)
  }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseidentifier, for: indexPath) as! CartTableViewCell
        let cartItem = cart.items[indexPath.row]
        cell.configureCell(with: cartItem)
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func removeButtonTapped(_ sender: UIButton) {
        let removedCar = cart.items[sender.tag]
        cart.removeCar(removedCar)
        updateUI()
    }
}
