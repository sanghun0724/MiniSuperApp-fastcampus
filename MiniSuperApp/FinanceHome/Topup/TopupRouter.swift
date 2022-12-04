//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by sangheon on 2022/11/19.
//

import ModernRIBs
// 뷰가 있는 리블렛의 경우 -> 부모에게 "나 끝났다" close 알려주면 dismiss 하는 역할은 부모의 역할
// 뷰가 없는 뷰레스 리블렛의 경우(topup) -> 부모가 직접 프리젠트 한경우가 없기때문에 디스미스 하지 않음 뷰레스는 지가 다해야함 지가 열고 지가 닫아야함(ex) cleanupViews())

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    
    private var navigationControllable: NavigationControllerable?

    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    
    private let enterAmountBuildable: EnterAmountBuildable
    private var enterAmountRouting: Routing?
    
    private let cardOnFileBildable: CardOnFileBuildable
    private var cardOnFileRouting: Routing?
    
    init(
        interactor: TopupInteractable,
        viewController: ViewControllable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable,
        enterAmountBuildable: EnterAmountBuildable,
        cardOnFileBuildable: CardOnFileBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        self.cardOnFileBildable = cardOnFileBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // 혹시하도 열려 있는거 있다면 
        if viewController.uiviewController.presentedViewController != nil, navigationControllable != nil {
            navigationControllable?.dismiss(completion: nil)
        }
    }
    
    func attachAddPaymentMethod() {
        if addPaymentMethodRouting != nil {
            return
        }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        presentInsideNavigation(router.viewControllable)
        attachChild(router)
        addPaymentMethodRouting = router
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else {
            return
        }
        
        dismissPresentNavigation(completion: nil)
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    func attachEnterAmount() {
        if enterAmountRouting != nil {
            return
        }
        
        let router = enterAmountBuildable.build(withListener: interactor)
        presentInsideNavigation(router.viewControllable)
        attachChild(router)
        enterAmountRouting = router
    }
    
    func detachEnterAmount() {
        guard let router = enterAmountRouting else {
            return
        }
        
        dismissPresentNavigation(completion: nil)
        detachChild(router)
        enterAmountRouting = nil
    }
    
    func attachCardOnFile(paymentMethods: [PaymentMethod]) {
        if cardOnFileRouting != nil {
            return
        }
        
        let router = cardOnFileBildable.build(withListener: interactor, paymentMethods: paymentMethods)
        navigationControllable?.pushViewController(router.viewControllable, animated: true)
        cardOnFileRouting = router
        attachChild(router)
    }
    
    func detachCardOnFile() {
        guard let router = cardOnFileRouting else {
            return
        }
        
        navigationControllable?.popViewController(animated: true)
        detachChild(router)
        cardOnFileRouting = nil
    }
    
    private func presentInsideNavigation(_ viewcontrollable: ViewControllable) {
        let navigation  = NavigationControllerable(root: viewcontrollable)
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        self.navigationControllable = navigation
        // popup view 띄울땐 이 객체는 뷰컨이 없기 때문에 밑의 부모가 준 뷰컨을 사용
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentNavigation(completion: (() -> Void)?) {
        if self.navigationControllable == nil {
            return
        }
        
        viewController.dismiss(completion: nil)
        self.navigationControllable = nil
    }

    // MARK: - Private

    private let viewController: ViewControllable
}
