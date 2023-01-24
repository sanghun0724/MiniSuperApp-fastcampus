//
//  CardOnFileDashBoardViewController.swift
//  MiniSuperApp
//
//  Created by 이상헌 on 2023/01/24.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashBoardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashBoardViewController: UIViewController, CardOnFileDashBoardPresentable, CardOnFileDashBoardViewControllable {

    weak var listener: CardOnFileDashBoardPresentableListener?
}
