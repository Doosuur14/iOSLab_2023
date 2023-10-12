//
//  Cart.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import Foundation

//struct CartItem: Hashable {
//    let car: Car
//    var quantity: Int
//}

struct Cart: Hashable{

    
    var items: [Car] = []
    
    // Add a car to the cart
    mutating func addCar(_ car: Car) {
        items.append(car)
    }
    
    
    mutating func removeCar(_ car: Car) {
        if let index = items.firstIndex(where: { $0.id == car.id }) {
            items.remove(at: index)
        }
    }
    
    func getTotalCost() -> Double {
        let total = items.reduce(0.0) {$0 + Double($1.carprice)!}
        return total
    }
    
    
    // Clear the cart
    mutating func clearCart() {
        items.removeAll()
    }
}
