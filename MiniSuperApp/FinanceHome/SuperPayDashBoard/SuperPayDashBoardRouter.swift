//
//  SuperPayDashBoardRouter.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs

protocol SuperPayDashBoardInteractable: Interactable {
    var router: SuperPayDashBoardRouting? { get set }
    var listener: SuperPayDashBoardListener? { get set }
}

protocol SuperPayDashBoardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SuperPayDashBoardRouter: ViewableRouter<SuperPayDashBoardInteractable, SuperPayDashBoardViewControllable>, SuperPayDashBoardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SuperPayDashBoardInteractable, viewController: SuperPayDashBoardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
