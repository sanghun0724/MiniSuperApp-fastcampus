//
//  SuperPayRouter.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs

protocol SuperPayInteractable: Interactable {
    var router: SuperPayRouting? { get set }
    var listener: SuperPayListener? { get set }
}

protocol SuperPayViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SuperPayRouter: ViewableRouter<SuperPayInteractable, SuperPayViewControllable>, SuperPayRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SuperPayInteractable, viewController: SuperPayViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
