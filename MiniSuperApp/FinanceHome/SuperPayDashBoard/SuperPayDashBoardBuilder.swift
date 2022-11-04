//
//  SuperPayDashBoardBuilder.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/10/30.
//

import ModernRIBs

protocol SuperPayDashBoardDependency: Dependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}
// DISCUSS: component는 바구니 역할이니 디펜덴시 받는게 맞음
// 그렇다면 balance는 어디서 와야할까?
// 1. 부모로 부터 받기 (여기서는 슈퍼페이는 극히일부적인 기능이니 부모로 부터 받음) -> SuperPayDashBoardDependency
// 2. 밑의 빌드함수에서 새로만듬
final class SuperPayDashBoardComponent: Component<SuperPayDashBoardDependency>, SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuperPayDashBoardBuildable: Buildable {
    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting
}

final class SuperPayDashBoardBuilder: Builder<SuperPayDashBoardDependency>, SuperPayDashBoardBuildable {

    override init(dependency: SuperPayDashBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting {
        let component = SuperPayDashBoardComponent(dependency: dependency)
        let viewController = SuperPayDashBoardViewController()
        let interactor = SuperPayDashBoardInteractor(
            presenter: viewController,
            dependency: component)
        interactor.listener = listener
        return SuperPayDashBoardRouter(interactor: interactor, viewController: viewController)
    }
}
