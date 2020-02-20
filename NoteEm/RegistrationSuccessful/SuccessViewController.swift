//
//  SuccessViewController.swift
//  NoteEm
//
//  Created by Intern on 12/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var goToHomeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        self.navigationController?.isNavigationBarHidden = true
        self.goToHomeButton.setTransparentUI(with: "Go To Home")
    }

    var coordiantor: OnboardCoordinator?

    @IBAction func goToHome(_ sender: Any) {
        coordiantor?.navigateToHomeScreen()
    }
}
