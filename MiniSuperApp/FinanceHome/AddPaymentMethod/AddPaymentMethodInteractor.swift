//
//  AddPaymentMethodInteractor.swift
//  MiniSuperApp
//
//  Created by sangheon on 2022/11/12.
//

import ModernRIBs
import Combine

protocol AddPaymentMethodRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddPaymentMethodPresentable: Presentable {
    var listener: AddPaymentMethodPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod)
}

protocol AddPaymentMethodInteractorDependency {
    var cardsOnFileRepository: CardOnfileRepository { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {
    
    weak var router: AddPaymentMethodRouting?
    weak var listener: AddPaymentMethodListener?
    
    private let dependency: AddPaymentMethodInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: AddPaymentMethodPresentable,
        dependency: AddPaymentMethodInteractorDependency
        ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.addPaymentMethodDidTapClose()
    }
    
    func didTapConfirm(with number: String, cvc: String, expiry: String) {
        dependency.cardsOnFileRepository.addCard(info: .init(number: number, cvc: cvc, expriration: expiry))
            .sink(receiveCompletion: {  _ in } ) { [weak self] method in
                self?.listener?.addPaymentMethodDidAddCard(paymentMethod: method)
            }.store(in: &cancellables)
    }
}
