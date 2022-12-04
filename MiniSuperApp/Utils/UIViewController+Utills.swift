//
//  UIViewController+Utills.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2022/11/27.
//

import UIKit

enum DissmissButtonType {
    case back, close
    
    var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}

extension UIViewController {
    
    func setupNavigationItem(with buttonType: DissmissButtonType ,target: Any? ,action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: buttonType.iconSystemName,
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
            style: .plain,
            target: target,
            action: action
        )
    }
}
