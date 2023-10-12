//
//  CartTableViewCell.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove from cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var removeButtonTapped: (() -> Void)?
    
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
    
    func configureCell(with cartItem: Car) {
        
        titleLabel.text = cartItem.carModel
        priceLabel.text = cartItem.carprice
        carImageView.image = cartItem.carImage

        
    }
    
    private func setUpLayout() {
        guard carImageView.superview == nil else { return }
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel,priceLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(carImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(removeButton)
       
        
        NSLayoutConstraint.activate([
            carImageView.heightAnchor.constraint(equalToConstant: 50),
            carImageView.widthAnchor.constraint(equalToConstant: 50),
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            removeButton.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            removeButton.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            removeButton.widthAnchor.constraint(equalToConstant: 100)        ])
    }
    
    @objc private func removeButtonTapped(_ sender: UIButton) {
            // Call the removeButtonTapped closure when the remove button is tapped
            removeButtonTapped?()
        }
}

//extension UITableViewCell {
//    static var reuseidentifier: String {
//        return String(describing: self)
//    }
//}


