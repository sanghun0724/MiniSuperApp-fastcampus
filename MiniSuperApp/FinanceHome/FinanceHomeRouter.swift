import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashBoardBuildable
    private var superPayRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable,
                  viewController: FinanceHomeViewControllable,
                  superPayDashboardBuildable: SuperPayDashBoardBuildable) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
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
}
