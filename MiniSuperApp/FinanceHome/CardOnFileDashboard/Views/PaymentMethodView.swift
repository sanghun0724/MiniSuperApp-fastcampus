//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/06.
//

import UIKit

final class PaymentMethodView: UIView {
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.text = "우릳은행"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "9999 9999"
        return label
    }()
    
    init(viewModel: PaymentMethodViewModel) {
        super.init(frame: .zero)
        
        setupViews()
        
        nameLabel.text = viewModel.name
        subTitleLabel.text = viewModel.digits
        backgroundColor = viewModel.color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .systemPurple
        addSubview(nameLabel)
        addSubview(subTitleLabel)
        
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            subTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
