//
//  CardOnFileDashBoardRouter.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import ModernRIBs

protocol CardOnFileDashBoardInteractable: Interactable {
    var router: CardOnFileDashBoardRouting? { get set }
    var listener: CardOnFileDashBoardListener? { get set }
}

protocol CardOnFileDashBoardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CardOnFileDashBoardRouter: ViewableRouter<CardOnFileDashBoardInteractable, CardOnFileDashBoardViewControllable>, CardOnFileDashBoardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CardOnFileDashBoardInteractable, viewController: CardOnFileDashBoardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
