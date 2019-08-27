//
//  OnboardingCoordinator.swift
//  NoteEm
//
//  Created by Intern on 08/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import UIKit

class OnboardCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    var toHomeCoordinator: (() -> Void)?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = RegistrationViewController.init(nibName: "RegistrationViewController", bundle: nil)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToSuccessScreen() {
        let vc = SuccessViewController.init(nibName: "SuccessViewController", bundle: nil)
        vc.coordiantor = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToHomeScreen() {
        toHomeCoordinator?()
    }
}
