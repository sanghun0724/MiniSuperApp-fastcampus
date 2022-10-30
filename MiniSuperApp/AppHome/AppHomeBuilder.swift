import ModernRIBs

public protocol AppHomeDependency: Dependency {
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
}

// MARK: - Builder

public protocol AppHomeBuildable: Buildable {
  func build(withListener listener: AppHomeListener) -> ViewableRouting
}
/// 리블렛 객체들을 생성하는 역할
public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {
  
  public override init(dependency: AppHomeDependency) {
    super.init(dependency: dependency)
  }
    /// 리블렛에 필요한 객체들을 생성
  public func build(withListener listener: AppHomeListener) -> ViewableRouting {
    let component = AppHomeComponent(dependency: dependency) // 로직을 수행하는데 있어서 필요한 객체들을 담는 바구니
    let viewController = AppHomeViewController()
    let interactor = AppHomeInteractor(presenter: viewController) // 비지니스 로직이 들어가는 '두뇌' 역할
    interactor.listener = listener
    
    let transportHomeBuilder = TransportHomeBuilder(dependency: component)
    
    return AppHomeRouter( // 리블렛간 이동을 담당하는 역할, 자식 리블렛을 뗏다 붙였다 하게 해줌 
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: transportHomeBuilder
    )
  }
}
