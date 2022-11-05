//
//  SuperPayDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/10/30.
//

import Foundation
import ModernRIBs
import Combine

protocol SuperPayDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashBoardPresentable: Presentable {
    var listener: SuperPayDashBoardPresentableListener? { get set }
    func updateBalance(_ balance: String)
}

protocol SuperPayDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}
// TIP: dependency 프로토콜 만드는 이유?
// 여러 곳에서 이 디펜덴시를 쓰게됨 (수정이 필요한 경우 한번에 체크 가능) (컴파일 체크)
protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    var balanceFormatter: NumberFormatter { get }
}

final class SuperPayDashBoardInteractor: PresentableInteractor<SuperPayDashBoardPresentable>, SuperPayDashBoardInteractable, SuperPayDashBoardPresentableListener {

    weak var router: SuperPayDashBoardRouting?
    weak var listener: SuperPayDashBoardListener?

    private let dependency: SuperPayDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    init(
        presenter: SuperPayDashBoardPresentable,
        dependency: SuperPayDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    // interator에서 UI를 업데이트 해줄때에는 presenter 호출
    // presenter -> presetable -> vc에서 confirm
    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.balance.sink { [weak self] balance in
        self?.dependency.balanceFormatter.string(from: NSNumber(value: balance)).map {
                self?.presenter.updateBalance($0)
            }
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
