//
//  CardOnFileDashBoardBuilder.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import ModernRIBs

protocol CardOnFileDashBoardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CardOnFileDashBoardComponent: Component<CardOnFileDashBoardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CardOnFileDashBoardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashBoardListener) -> CardOnFileDashBoardRouting
}

final class CardOnFileDashBoardBuilder: Builder<CardOnFileDashBoardDependency>, CardOnFileDashBoardBuildable {

    override init(dependency: CardOnFileDashBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CardOnFileDashBoardListener) -> CardOnFileDashBoardRouting {
        let component = CardOnFileDashBoardComponent(dependency: dependency)
        let viewController = CardOnFileDashBoardViewController()
        let interactor = CardOnFileDashBoardInteractor(presenter: viewController)
        interactor.listener = listener
        return CardOnFileDashBoardRouter(interactor: interactor, viewController: viewController)
    }
}
