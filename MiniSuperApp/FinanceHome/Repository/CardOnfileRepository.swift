//
//  CardOnfileRepository.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/06.
//

import Foundation

protocol CardOnfileRepository {
    var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnfileRepositoryImp: CardOnfileRepository {
    var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#000000", isPrimary: false),
        PaymentMethod(id: "1", name: "신한은행", digits: "0123", color: "#000000", isPrimary: false),
        PaymentMethod(id: "2", name: "현대은행", digits: "0123", color: "#000000", isPrimary: false),
        PaymentMethod(id: "3", name: "기업은행", digits: "0123", color: "#000000", isPrimary: false),
        PaymentMethod(id: "4", name: "케이은행", digits: "0123", color: "#000000", isPrimary: false)
    ])
    
    
}
