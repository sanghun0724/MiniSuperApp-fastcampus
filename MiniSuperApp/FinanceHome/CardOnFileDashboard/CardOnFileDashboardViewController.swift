//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/05.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    func didTapAddPaymentMethod()
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {

    weak var listener: CardOnFileDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "슈퍼페이 잔고"
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cardOnFileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    init() {
      super.init(nibName: nil, bundle: nil)
      
      setupViews()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setupViews()
    }
    
    func update(with viewModels: [PaymentMethodViewModel]) {
        cardOnFileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // [PaymentMethodViewModel] -> [PaymentMethodView]
        let views = viewModels.map(PaymentMethodView.init)
        views.forEach {
            $0.roundCorners()
            cardOnFileStackView.addArrangedSubview($0)
        }
        cardOnFileStackView.addArrangedSubview(addMethodButton)
        
        let heightConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 60) }
        NSLayoutConstraint.activate(heightConstraints)
    }
    
    private lazy var addMethodButton: AddPaymentMethodButton = {
       let button = AddPaymentMethodButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    func setupViews() {
        view.addSubview(headerStackView)
        view.addSubview(cardOnFileStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)
        
        cardOnFileStackView.addArrangedSubview(addMethodButton)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardOnFileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardOnFileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardOnFileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardOnFileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addMethodButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    func seeAllButtonTapped() {
        print("123")
    }
    
    // vc에서 이벤트가 발생하면 이는 vc는 listener에게 전달 
    @objc
    func addButtonDidTap() {
        listener?.didTapAddPaymentMethod()
    }
}
