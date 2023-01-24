//
//  CardOnFileDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import ModernRIBs

protocol CardOnFileDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashBoardPresentable: Presentable {
    var listener: CardOnFileDashBoardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol CardOnFileDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class CardOnFileDashBoardInteractor: PresentableInteractor<CardOnFileDashBoardPresentable>, CardOnFileDashBoardInteractable, CardOnFileDashBoardPresentableListener {

    weak var router: CardOnFileDashBoardRouting?
    weak var listener: CardOnFileDashBoardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: CardOnFileDashBoardPresentable) {
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
