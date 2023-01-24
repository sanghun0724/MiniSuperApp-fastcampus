//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
