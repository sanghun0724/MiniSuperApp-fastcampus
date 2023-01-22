import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashBoard(view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private var superPayDashBoardBuilder: SuperPayDashBoardBuilder
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable, viewController: FinanceHomeViewControllable, superPayDashBoardBuilder: SuperPayDashBoardBuilder) {
        self.superPayDashBoardBuilder = superPayDashBoardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashBoard() {
        let router = superPayDashBoardBuilder.build(withListener: interactor)
        
        let dashBoard = router.viewControllable
        viewController.addDashBoard(view: dashBoard)
    }
}
