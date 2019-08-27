//
//  AppCoordinator.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {

    let window: UIWindow
    var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {

        let vc = SplashViewController(nibName: "SplashViewController", bundle: nil)
        vc.coordinator = self
        navigationController = UINavigationController.init(rootViewController: vc)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func navigateToLoginScreen() {

        let myCoordinator = OnboardCoordinator(navigationController: navigationController)
        self.store(coordinator: myCoordinator)
        myCoordinator.start()
        myCoordinator.toHomeCoordinator = { [weak self] in
            self?.navigateToHomeScreen()
        }

        myCoordinator.completionHandler = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }

    }

    func navigateToHomeScreen(alreadyLoggedIn: Bool? = false) {

        let myCoordinator = HomeCoordinator(navigationController: navigationController)
        self.store(coordinator: myCoordinator)
        alreadyLoggedIn! ?  myCoordinator.navigateToHome() : myCoordinator.start()

        myCoordinator.completionHandler = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }
    }
}
