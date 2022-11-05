import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    /// 잔액을 업데이트 할때 쓰는 Publisher
    private let balancePublisher: CurrentValuePublisher<Double>
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>
    ) {
        self.balancePublisher = balance
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
    let balanccePublisher = CurrentValuePublisher<Double>(10000)
    let component = FinanceHomeComponent(dependency: dependency,
                                           balance: balanccePublisher) // 자식 리블렛들이 필요한 것들도 담는 바구니..
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
      
    let superPayDashBoardBuilder = SuperPayDashBoardBuilder(dependency: component)
      
      return FinanceHomeRouter(interactor: interactor,
                               viewController: viewController,
                               superPayDashboardBuildable: superPayDashBoardBuilder)
  }
}
