//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/06.
//

import UIKit

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor
    
    init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = UIColor(hex: paymentMethod.color) ?? .gray
    }
}
