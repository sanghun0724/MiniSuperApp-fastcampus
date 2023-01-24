import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashBoardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashBoard(view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {

    private var superPayDashBoardBuilder: SuperPayDashBoardBuilder
    private var superPayRouting: SuperPayDashBoardRouting?
    
    private var cardOnFileDashBoardBuilder: CardOnFileDashBoardBuilder
    private var cardOnFileRouting: CardOnFileDashBoardRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable, viewController: FinanceHomeViewControllable, superPayDashBoardBuilder: SuperPayDashBoardBuilder, cardOnFileDashBoardBuilder: CardOnFileDashBoardBuilder) {
        self.superPayDashBoardBuilder = superPayDashBoardBuilder
        self.cardOnFileDashBoardBuilder = cardOnFileDashBoardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashBoard() {
        if superPayRouting != nil {
            return
        }
        let router = superPayDashBoardBuilder.build(withListener: interactor)
        
        let dashBoard = router.viewControllable
        viewController.addDashBoard(view: dashBoard)
        
        self.superPayRouting = router
        attachChild(router)
    }
    
    func attachCardOnFileDashBoard() {
        if cardOnFileRouting != nil {
            return
        }
        
        let router = cardOnFileDashBoardBuilder.build(withListener: interactor)
        
        let dashBoard = router.viewControllable
        viewController.addDashBoard(view: dashBoard)
        
        self.cardOnFileRouting = router
        attachChild(router)
    }
}
