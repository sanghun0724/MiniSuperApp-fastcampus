import ModernRIBs
import Combine

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublish }
    var balancePublish : CurrentValuePublisher<Double>
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>
    ) {
        self.balancePublish = balance
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
      let balance = CurrentValuePublisher(0.0)
    let component = FinanceHomeComponent(dependency: dependency, balance: balance)
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
