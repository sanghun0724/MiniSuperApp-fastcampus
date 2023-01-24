//
//  CardOnFileDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import ModernRIBs
import Combine

protocol CardOnFileDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashBoardPresentable: Presentable {
    var listener: CardOnFileDashBoardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashBoardInteractorDependency {
    var cardOnFileRepository: CardOnfileRepository { get }
}


protocol CardOnFileDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class CardOnFileDashBoardInteractor: PresentableInteractor<CardOnFileDashBoardPresentable>, CardOnFileDashBoardInteractable, CardOnFileDashBoardPresentableListener {
    
    weak var router: CardOnFileDashBoardRouting?
    weak var listener: CardOnFileDashBoardListener?
    private var cancellable: Set<AnyCancellable>
    
    private let dependency: CardOnFileDashBoardInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: CardOnFileDashBoardPresentable,
        dependency: CardOnFileDashBoardInteractorDependency
        ) {
        self.dependency = dependency
        self.cancellable = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.cardOnFileRepository.cardOnfile.sink { [weak self] methods in
            let viewModel = methods.prefix(5).map (PaymentMethodViewModel.init)
            self?.presenter.update(with: viewModel)
        }.store(in: &cancellable)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapAddPaymentMethod() {
        
    }
}
