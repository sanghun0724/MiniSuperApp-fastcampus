import ModernRIBs

protocol FinanceHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}
// TIP: 부모로부터 자식한테 데이터를 줄때에는 스트림을 이용함
// WHY? -> 리블렛은 여러 자식 리블렛을 가질 수 있음 -> 1: n 관계 -> 스트림 바인딩 구독 유용
// +) 반대로 자식은 부모를 하나밖에 못가지기 떄문에 -> 1:1 관계 -> delegate 사용 유용
final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {
    var cardsOnFileRepository: CardOnfileRepository
    
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    /// 잔액을 업데이트 할때 쓰는 Publisher
    private let balancePublisher: CurrentValuePublisher<Double>
    var topupBaseViewController: ViewControllable
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>,
        cardOnfileRepository: CardOnfileRepository,
        topupBaseViewController: ViewControllable
    ) {
        self.balancePublisher = balance
        self.cardsOnFileRepository = cardOnfileRepository
        self.topupBaseViewController = topupBaseViewController
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
        let viewController = FinanceHomeViewController()
        
        let component = FinanceHomeComponent(dependency: dependency,
                                             balance: balanccePublisher,
                                             cardOnfileRepository: CardOnfileRepositoryImp(),
                                             topupBaseViewController: viewController) // 자식 리블렛들이 필요한 것들도 담는 바구니..
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashBoardBuilder = SuperPayDashBoardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let topupBuilder = TopupBuilder(dependency: component)
        
        return FinanceHomeRouter(interactor: interactor,
                                 viewController: viewController,
                                 superPayDashboardBuildable: superPayDashBoardBuilder,
                                 cardOnFileDatshboardBuildable: cardOnFileDashboardBuilder,
                                 addPaymentMethodBuildable: addPaymentMethodBuilder,
                                 topupBuildable: topupBuilder )
    }
}
