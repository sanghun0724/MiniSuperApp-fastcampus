//
//  UIViewController+Utills.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/27.
//

import UIKit

extension UIViewController {
    
    func setupNavigationItem(target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark",
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
            style: .plain,
            target: target,
            action: action
        )
    }
}
