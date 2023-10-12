//
//  ViewController.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import UIKit

class CarViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.estimatedRowHeight = 1000
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseidentifier)
        return table
    }()
    var cartCountLabel: UILabel = {
        let mylabel = UILabel()
        mylabel.textColor = UIColor.black
        mylabel.font = UIFont.systemFont(ofSize: 15)
        return mylabel
    }()
   
    var cars: [Car] = []
    var cart = Cart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = Array(arrayLiteral: Car(id: UUID(), carModel: "Name: bmw2018", carprice: "Price: $290860000", carImage: UIImage(named: "BMW.jpeg")), Car(id: UUID(), carModel: "Name: Porsche", carprice: "Price: $12345900", carImage: UIImage(named: "porsche.jpeg")), Car(id: UUID(), carModel: "Lamborghini", carprice: "Price: $1267000000", carImage: UIImage(named: "lambo.jpeg")))
        
        self.view.backgroundColor = .systemPink
        view.addSubview(tableView)
       // view.addSubview(cartButton)
       // cart = Cart()
        setUpLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(showCart))

        cartButton.title = "\(cartCountLabel.text ?? "")"

            navigationItem.rightBarButtonItem = cartButton
//        navigationItem.rightBarButtonItem?.customView = cartCountLabel
//        navigationItem.rightBarButtonItem = cartButton
    }

    
    
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}

extension CarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseidentifier, for: indexPath) as! CarTableViewCell
        let car = cars[indexPath.row]
        cell.configureCell(with: car)
        cell.addTocartButton.tag = indexPath.row
        cell.addTocartButton.addTarget(self, action: #selector(addToCartButtonTapped(_:)), for: .touchUpInside)
        cell.accessoryView = cell.addTocartButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    @objc func addToCartButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let selectedCar = cars[indexPath.row]
            cart.items.append(selectedCar)
        }
        updateCartCount()
    }
    ///function to update the number of items in cart
    @objc func updateCartCount() {
        let cartCount = cart.items.count
        cartCountLabel.text = "\(cartCount)"
        navigationItem.rightBarButtonItem?.customView = cartCountLabel
        
    }
    @objc func showCart() {
        print("button tapped")
        let secondVC = CartViewController()
        secondVC.cart = cart
        navigationController?.pushViewController(secondVC, animated: true)
    }
}



