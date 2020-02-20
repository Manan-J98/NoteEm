//
//  LoginViewController.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoginView {
    func showErrorMessage(error: Bool, message: String)
    func loginSuccessfull()
    func startAnimating()
    func stopAnimating()
}

class LoginViewController: UIViewController, LoginView {

    func showErrorMessage(error: Bool, message: String) {
        self.showCustomAlert(error: error, message: message)
    }

    @IBOutlet weak var loader: NVActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var toggleButton: UIButton!

    var coordinator: HomeCoordinator?

    var presenter: LoginViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPresenter()
    }

    private func setupViews() {
        self.navigationController?.isNavigationBarHidden = true
        loginButton.setTransparentUI(with: "Login")
    }

     func setupPresenter() {
        presenter.loginView = self
    }

    func loginSuccessfull() {
        coordinator?.navigateToHome()
    }

    func startAnimating() {
        loader.startAnimating()
    }

    func stopAnimating() {
        loader.stopAnimating()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        presenter.authenticateUser(username: username.text ?? "", password: password.text ?? "") { (user,error) in
            print(error)
        }
    }
    @IBAction func togglePassword(_ sender: Any) {
        toggleButton.isSelected.toggle()
        password.isSecureTextEntry = !toggleButton.isSelected
    }
}
