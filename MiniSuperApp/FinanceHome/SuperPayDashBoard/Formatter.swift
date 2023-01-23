//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
