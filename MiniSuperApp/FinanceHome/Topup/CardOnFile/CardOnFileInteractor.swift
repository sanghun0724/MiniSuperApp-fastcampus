//
//  CardOnFileInteractor.swift
//  MiniSuperApp
//
//  Created by sangheon on 2022/12/04.
//

import ModernRIBs

protocol CardOnFileRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFilePresentable: Presentable {
    var listener: CardOnFilePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileListener: AnyObject {
    func cardOnfileDidTapClose()
    func cardOnfileDidTapAddCard()
    func cardOnFileDidSelect(at index: Int)
}

final class CardOnFileInteractor: PresentableInteractor<CardOnFilePresentable>, CardOnFileInteractable, CardOnFilePresentableListener {
    
    weak var router: CardOnFileRouting?
    weak var listener: CardOnFileListener?

    private let paymentMethods: [PaymentMethod]
    
    init(
        presenter: CardOnFilePresentable,
        paymentMethods: [PaymentMethod]
    ) {
        self.paymentMethods = paymentMethods
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.update(with: paymentMethods.map(PaymentMethodViewModel.init))
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.cardOnfileDidTapClose()
    }
    
    func didSelectItem(at index: Int) {
        if index >= paymentMethods.count {
            listener?.cardOnfileDidTapClose()
        } else {
            listener?.cardOnFileDidSelect(at: index)
        }
    }
}
