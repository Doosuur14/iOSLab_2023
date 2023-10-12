//
//  TableViewCell.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import UIKit



class CarTableViewCell: UITableViewCell {
    
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var addTocartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        carImageView.image = nil
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with car: Car) {
        carImageView.image = car.carImage
        titleLabel.text = car.carModel
        priceLabel.text = car.carprice
        
    }
    
    private func setUpLayout() {
        guard carImageView.superview == nil else { return }
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel,priceLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(carImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(addTocartButton)
        
        
        NSLayoutConstraint.activate([
            carImageView.heightAnchor.constraint(equalToConstant: 50),
            carImageView.widthAnchor.constraint(equalToConstant: 50),
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant:16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
          addTocartButton.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            addTocartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addTocartButton.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            addTocartButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension UITableViewCell {
    static var reuseidentifier: String {
        return String(describing: self)
    }
}
