//
//  SuperPayBuilder.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs

protocol SuperPayDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SuperPayComponent: Component<SuperPayDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuperPayBuildable: Buildable {
    func build(withListener listener: SuperPayListener) -> SuperPayRouting
}

final class SuperPayBuilder: Builder<SuperPayDependency>, SuperPayBuildable {

    override init(dependency: SuperPayDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayListener) -> SuperPayRouting {
        let component = SuperPayComponent(dependency: dependency)
        let viewController = SuperPayViewController()
        let interactor = SuperPayInteractor(presenter: viewController)
        interactor.listener = listener
        return SuperPayRouter(interactor: interactor, viewController: viewController)
    }
}
