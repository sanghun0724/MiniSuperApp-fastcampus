import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashBoardListener, AddPaymentMethodListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashBoard(view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    let superPayDashBoardBuildeable: SuperPayDashBoardBuildable
    private var superPayRouting: Routing?
    
    let cardOnFileDashBoardBuildable: CardOnFileDashBoardBuildable
    private var cardOnFileRouting: Routing?
    
    let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashBoardBuildeable: SuperPayDashBoardBuildable,
        cardOnFileDashBoardBuildable: CardOnFileDashBoardBuildable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable
    ) {
        self.superPayDashBoardBuildeable = superPayDashBoardBuildeable
        self.cardOnFileDashBoardBuildable = cardOnFileDashBoardBuildable
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashBoard() { // 자식 리블렛을 담당하는 리스너 -> interactor
        if superPayRouting != nil {
            return
        }
        let router = superPayDashBoardBuildeable.build(withListener: interactor) // 1
        
        let dashBoard = router.viewControllable // 2
        
        viewController.addDashBoard(view: dashBoard) // 3
        
        self.superPayRouting = router
        attachChild(router)
    }
    
    func attachCardOnFileDashBoard() {
        if cardOnFileRouting != nil {
            return
        }
        
        let router = cardOnFileDashBoardBuildable.build(withListener: interactor)
        
        let dashBoard = router.viewControllable
        viewController.addDashBoard(view: dashBoard)
        
        self.cardOnFileRouting = router
        attachChild(router)
    }
    
    func attachAddPaymentMethod() {
        if addPaymentRouting != nil {
            return
        }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        viewControllable.present(router.viewControllable, animated: true, completion: nil)
        
        self.addPaymentRouting = router
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
      
    }
}
