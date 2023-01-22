import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublish }
    var balancePublish: CurrentValuePublisher<Double>
    
    init(
        dependency: FinanceHomeDependency,
        balancePublish: CurrentValuePublisher<Double>
    ) {
        self.balancePublish = balancePublish
        super.init(dependency: dependency)
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
    let balancePublish = CurrentValuePublisher<Double>(0)
    let component = FinanceHomeComponent(
        dependency: dependency,
        balancePublish: balancePublish
    )
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    let superPayDashBoardBuilder = SuperPayDashBoardBuilder(dependency: component)
    
    interactor.listener = listener
    return FinanceHomeRouter(
        interactor: interactor,
        viewController: viewController,
        superPayDashBoardBuilder: superPayDashBoardBuilder
    )
  }
}
