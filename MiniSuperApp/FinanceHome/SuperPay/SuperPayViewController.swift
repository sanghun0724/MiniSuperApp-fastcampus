//
//  SuperPayViewController.swift
//  MiniSuperApp
//
//  Created by sangheon on 2023/01/22.
//

import ModernRIBs
import UIKit

protocol SuperPayPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SuperPayViewController: UIViewController, SuperPayPresentable, SuperPayViewControllable {

    weak var listener: SuperPayPresentableListener?
}
