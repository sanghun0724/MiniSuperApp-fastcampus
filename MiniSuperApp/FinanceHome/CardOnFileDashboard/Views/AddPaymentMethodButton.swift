//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/06.
//

import UIKit

final class AddPaymentMethodButton: UIControl {
    
    private let plusIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,weight: .semibold)))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(plusIcon)
        
        NSLayoutConstraint.activate([
            plusIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
