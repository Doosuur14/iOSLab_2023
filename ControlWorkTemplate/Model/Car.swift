//
//  Car.swift
//  ControlWorkTemplate
//
//  Created by Faki Doosuur Doris on 10.10.2023.
//

import Foundation
import UIKit

struct Car: Hashable, Identifiable {
    var id = UUID()
    let carModel: String
    let carprice: String
    let carImage: UIImage?
}
