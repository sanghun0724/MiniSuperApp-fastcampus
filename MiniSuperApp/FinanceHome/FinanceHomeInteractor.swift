import ModernRIBs
import UIKit

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDashBoard()
    func attatchCardOnFileDashboard()
    func attatchAddPaymentMethod()
    func detachAddPaymentMethod()
    func attatchTopup()
    func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinanceHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener, AdaptivePresentationControllerDelegate {
    
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FinanceHomePresentable) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init(presenter: presenter)
        presenter.listener = self
        self.presentationDelegateProxy.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSuperPayDashBoard()
        router?.attatchCardOnFileDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func presentationControllerDidDismiss() {
        router?.detachAddPaymentMethod()
    }
    
    // MARK: - CardOnFileDashboardListener
    func cardOnFileDashboardDidTapAddPaymentMethod() {
        router?.attatchAddPaymentMethod()
    }
    
    // MARK: - AddPaymentMethodListener
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        router?.detachAddPaymentMethod()
    }
    
    func superPayDashboardDidTapTopup() {
        router?.attatchTopup()
    }
    
    func topupDidClose() {
        router?.detachTopup()
    }
}
