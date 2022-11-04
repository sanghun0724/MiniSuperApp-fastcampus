//
//  SuperPayDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/10/30.
//

import ModernRIBs

protocol SuperPayDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashBoardPresentable: Presentable {
    var listener: SuperPayDashBoardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuperPayDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}
// TIP: dependency 프로토콜 만드는 이유?
// 여러 곳에서 이 디펜덴시를 쓰게됨 (수정이 필요한 경우 한번에 체크 가능) (컴파일 체크)
protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashBoardInteractor: PresentableInteractor<SuperPayDashBoardPresentable>, SuperPayDashBoardInteractable, SuperPayDashBoardPresentableListener {

    weak var router: SuperPayDashBoardRouting?
    weak var listener: SuperPayDashBoardListener?

    private let dependency: SuperPayDashboardInteractorDependency
    init(
        presenter: SuperPayDashBoardPresentable,
        dependency: SuperPayDashboardInteractorDependency
    ) {
        self.dependency = dependency
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
}
