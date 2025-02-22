//
//  EnterAmountRouter.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/27.
//

import ModernRIBs

protocol EnterAmountInteractable: Interactable {
    var router: EnterAmountRouting? { get set }
    var listener: EnterAmountListener? { get set }
}

protocol EnterAmountViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EnterAmountRouter: ViewableRouter<EnterAmountInteractable, EnterAmountViewControllable>, EnterAmountRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EnterAmountInteractable, viewController: EnterAmountViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
