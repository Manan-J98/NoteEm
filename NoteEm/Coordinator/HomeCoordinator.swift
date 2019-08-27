//
//  MyCoordinator.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
//        let vc = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        let viewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        viewController.coordinator = self
        viewController.presenter = LoginViewPresenter()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func navigateToHome() {
        let viewController = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func logout() {
        try? Auth.auth().signOut()
        let window = UIWindow()
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }

    func navigateToEditUserNoteViewController(presenter: EditUserNotePresenter) {
        let viewController = EditUserNoteViewController(nibName: "EditUserNoteViewController", bundle: nil)
        viewController.coordinator = self
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }

    func navigateToAddUserNoteController(viewModel: NoteViewModel, delegate: HomeViewController) {
        let viewController = AddUserNotesViewController.init(nibName: "AddUserNotesViewController", bundle: nil)
        viewController.coordinator = self
        viewController.delegate = delegate
        viewController.viewModel = viewModel
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(viewController, animated: true, completion: nil)
    }

    func customAppAlert(message: String, confirmationHandler: (() -> Void)?, negationHandler: (() -> Void)? = nil) {
        let viewController = CustomAlertViewController(message: message, confirmAction: confirmationHandler, negationAction: negationHandler)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(viewController, animated: true, completion: {
            viewController.messageLabel.text = message
        })

    }

}
