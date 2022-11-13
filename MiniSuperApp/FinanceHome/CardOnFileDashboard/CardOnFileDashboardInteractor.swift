//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/05.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTapAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardsOnFileRepository: CardOnfileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?
    
    private let dependency: CardOnFileDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: CardOnFileDashboardPresentable,
         dependency: CardOnFileDashboardInteractorDependency) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.cardsOnFileRepository.cardOnfile.sink { methods in
            let viewModels = methods.prefix(3).map(PaymentMethodViewModel.init)
            self.presenter.update(with: viewModels)
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
       
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    // interactor은 vc -> 리스너에게 받은 func를 구현
    // 리블렛 끼리의 통신은 interactor(두뇌끼리)
    // 부모(finance)에게 모달 띄우도록
    func didTapAddPaymentMethod() {
        listener?.cardOnFileDashboardDidTapAddPaymentMethod()
    }
}
