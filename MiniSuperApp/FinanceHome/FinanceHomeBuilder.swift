import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double>
    
    init(
        dependency: Dependency,
        balance: ReadOnlyCurrentValuePublisher<Double>
    ) {
        self.balance = balance
        super.dependency = dependency
    }
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    let component = FinanceHomeComponent(dependency: dependency)
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let superPayDashBoardBuilder = SuperPayDashBoardBuilder(dependency: component)
      
    return FinanceHomeRouter(
        interactor: interactor,
        viewController: viewController,
        superPayDashBoardBuildeable: superPayDashBoardBuilder
    )
  }
}
