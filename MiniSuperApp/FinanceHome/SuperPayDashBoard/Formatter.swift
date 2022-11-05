//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/05.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
