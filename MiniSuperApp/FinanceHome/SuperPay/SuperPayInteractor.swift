//
//  SuperPayInteractor.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs

protocol SuperPayRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayPresentable: Presentable {
    var listener: SuperPayPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuperPayListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SuperPayInteractor: PresentableInteractor<SuperPayPresentable>, SuperPayInteractable, SuperPayPresentableListener {

    weak var router: SuperPayRouting?
    weak var listener: SuperPayListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SuperPayPresentable) {
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
