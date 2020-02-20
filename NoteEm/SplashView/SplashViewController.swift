//
//  SplashViewController.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var splashImage: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!

    // MARK: Variables
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    func setupUI() {
        registerButton.setTransparentUI(with: "Register")
        homeButton.setTransparentUI(with: "Home")
        
    }
   
    func checkLoggedInStatus() {
        if Auth.auth().currentUser != nil {
            coordinator?.navigateToHomeScreen(alreadyLoggedIn: true)
        } else {
            coordinator?.navigateToHomeScreen(alreadyLoggedIn: false)
        }

    }

    @IBAction func loginAction(_ sender: Any) {
        coordinator?.navigateToLoginScreen()
    }

    @IBAction func homeButtonAction(_ sender: Any) {
        checkLoggedInStatus()
    }

}
