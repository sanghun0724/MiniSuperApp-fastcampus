//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by sangheon on 2022/11/19.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    
    func attachEnterAmount()
    func detachEnterAmount()
    
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardsOnFileRepository: CardOnfileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {
    
    
    weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    private var paymentMethods: [PaymentMethod] {
        dependency.cardsOnFileRepository.cardOnfile.value
    }

    private let dependency: TopupInteractorDependency
    
    init(
        dependency: TopupInteractorDependency
    ) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        self.dependency = dependency
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let card = dependency.cardsOnFileRepository.cardOnfile.value.first {
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            // 카드추가
            router?.attachAddPaymentMethod()
        }
        
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        
    }
    
    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }
    
    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }
    
    func cardOnfileDidTapClose() {
        router?.detachCardOnFile()
    }
    
    func cardOnfileDidTapAddCard() {
        // attach add card
    }
    
    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }
}
