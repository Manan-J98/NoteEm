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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        registerButton.center.x += self.view.bounds.width
        homeButton.center.x += self.view.bounds.width
    }



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.splashImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.registerButton.center.x -= self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseInOut, animations: {
            self.homeButton.center.x -= self.view.bounds.width
        }, completion: nil)
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
