//
//  SuccessViewController.swift
//  NoteEm
//
//  Created by Intern on 12/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var coordiantor: OnboardCoordinator?

    @IBAction func goToHome(_ sender: Any) {
        coordiantor?.navigateToHomeScreen()
    }
}
