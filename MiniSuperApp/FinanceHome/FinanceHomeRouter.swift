import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashBoard(view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    let superPayDashBoardBuildeable: SuperPayDashBoardBuildable
    private var superPayRouting: Routing?
  
  // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable, viewController: FinanceHomeViewControllable, superPayDashBoardBuildeable: SuperPayDashBoardBuildable) {
    self.superPayDashBoardBuildeable = superPayDashBoardBuildeable
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
}
