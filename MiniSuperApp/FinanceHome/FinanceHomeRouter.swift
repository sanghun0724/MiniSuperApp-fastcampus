import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashboardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashBoardBuildable
    private var superPayRouting: Routing?
    
    private let cardOnfileDashboardBuildable: CardOnFileDashboardBuildable
    private var cardOnFileRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable,
                  viewController: FinanceHomeViewControllable,
                  superPayDashboardBuildable: SuperPayDashBoardBuildable,
         cardOnFileDatshboardBuildable: CardOnFileDashboardBuildable) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnfileDashboardBuildable = cardOnFileDatshboardBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashBoard() {
        if superPayRouting != nil {
            return // 똑같은 Router를 두번 붙이지 않게 방어코드
        } 
        // 자식 리블렛의 listener은 -> interactor가 됨
        let router = superPayDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        self.superPayRouting = router
        attachChild(router)
    }
    
    func attatchCardOnFileDashboard() {
        if cardOnFileRouting != nil {
            return
        }
        
        let router  = cardOnfileDashboardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        self.cardOnFileRouting = router
        attachChild(router)
    }
}
