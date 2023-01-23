//
//  SuperPayDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs
import Combine
import Foundation

protocol SuperPayDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashBoardPresentable: Presentable {
    var listener: SuperPayDashBoardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateBalance(_ balance: String)
}

protocol SuperPayDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol SuperPayDashBoardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    var formatter: NumberFormatter { get }
}

final class SuperPayDashBoardInteractor: PresentableInteractor<SuperPayDashBoardPresentable>, SuperPayDashBoardInteractable, SuperPayDashBoardPresentableListener {

    weak var router: SuperPayDashBoardRouting?
    weak var listener: SuperPayDashBoardListener?
    private var cancellables: Set<AnyCancellable>
    
    private let dependency: SuperPayDashBoardInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: SuperPayDashBoardPresentable,
        dependency: SuperPayDashBoardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.balance.sink { [weak self] balance in
            self?.dependency.formatter.string(from: NSNumber(value: balance)).map ({
                self?.presenter.updateBalance($0)
            })
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
