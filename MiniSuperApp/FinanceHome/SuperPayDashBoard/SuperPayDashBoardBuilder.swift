//
//  SuperPayDashBoardBuilder.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs

protocol SuperPayDashBoardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashBoardComponent: Component<SuperPayDashBoardDependency>, SuperPayDashBoardInteractorDependency {
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
        let interactor = SuperPayDashBoardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SuperPayDashBoardRouter(interactor: interactor, viewController: viewController)
    }
}
