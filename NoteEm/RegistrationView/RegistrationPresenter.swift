//
//  RegistrationPresenter.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import NVActivityIndicatorView

protocol RegistrationPresenterDelegate: class {
    func showErrorMessage(error: Bool, message: String)
    func navigateToHome()
    func startAnimating()
    func stopAnimating()
}

class RegistrationPresenter {

    private enum RegistrationField: Hashable {
        case username, email, contact, password, confirmPassword
    }

    var registrationView: RegistrationViewController

    weak var view: RegistrationPresenterDelegate?

    init(registrationView: RegistrationViewController) {
        self.registrationView = registrationView
        self.setupViewModel()
    }

    private var rows: [RegistrationField] = [.username, .email, .contact, .password, .confirmPassword]

    private var viewModels = [RegistrationField: GeneralTextViewModel]()

    func getRows() -> Int {
        return rows.count
    }

    private func setupViewModel() {
        for row in rows {
            viewModels[row] = registrationViewModel(forRow: row)
        }
    }

    func viewModel(forRow index: IndexPath) -> GeneralTextViewModel {
        var vm = viewModels[rows[index.row]]
        vm!.indexPath = index
        return vm!
    }

    private func cellTextDidChange(text: String?, index: IndexPath?) {
        let row = rows[index!.row]
        var model = viewModels[row]
        model?.textValue = text ?? ""
        viewModels[row] = model
    }

    private func registrationViewModel(forRow row: RegistrationField) -> GeneralTextViewModel {
        switch row {
        case .username:
            return GeneralTextViewModel(placeholder: "Full Name", textValue: "", isSecureText: false)
        case .email:
             return GeneralTextViewModel(placeholder: "Email Address", textValue: "", isSecureText: false)
        case .contact:
           return GeneralTextViewModel(placeholder: "Contact Number", textValue: "", isSecureText: false)
        case .password:
            return GeneralTextViewModel(placeholder: "Password", textValue: "", isSecureText: true)
        case .confirmPassword:
            return GeneralTextViewModel(placeholder: "Confirm Password", textValue: "", isSecureText: true)
        }
    }

    func checkDataAndNavigate() {
        if isAllDataValid() {
            if let email = viewModels[.email]?.textValue {
                let password = Singleton.sharedInstance.encrypt(text: viewModels[.password]?.textValue ?? "")
                authorizeNewUser(email: email, password: password)
            }

        }
    }

    private func authorizeNewUser(email: String, password: String) {

        view?.startAnimating()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            self.view?.stopAnimating()
            if let error = error {
                self.view?.showErrorMessage(error: true, message: error.localizedDescription)
                return
            }
            self.createUser(userId: user?.user.uid ?? "")
        }
    }

    private func createUser(userId: String) {

        var userData = [String: Any]()
        for row in rows {
            switch row {
            case .username:
                let viewModel = viewModels[row]
                userData["name"] = viewModel?.textValue
            case .email:
                let viewModel = viewModels[row]
                userData["email"] = viewModel?.textValue
            case .contact:
                let viewModel = viewModels[row]
                userData["contact"] = viewModel?.textValue
            case .password:
                let viewModel = viewModels[row]
                userData["password"] = Singleton.sharedInstance.encrypt(text: viewModel?.textValue ?? "")
            case .confirmPassword:
                break
            }
        }
        userData["note"] = [String]()
        let newUserReference = Singleton.sharedInstance.db.collection("users").document(userId)
        newUserReference.setData(userData)
        view?.navigateToHome()
        }

    private func isAllDataValid() -> Bool {
        let row: RegistrationField = .username
        switch row {
        case .username:
            let viewModel = viewModels[row]
            if viewModel?.textValue.trimmed() == "" {
                view?.showErrorMessage(error: true, message: "Name cannot be empty")
                return false
            }
            fallthrough
        case .email:
            let viewModel = viewModels[row]
            if viewModel?.textValue.trimmed() == "" {
                view?.showErrorMessage(error: true, message: "Email cannot be empty")
                return false
            }
            fallthrough
        case .contact:
            let viewModel = viewModels[row]
            if viewModel?.textValue.trimmed() == "" {
                view?.showErrorMessage(error: true, message: "Contact number cannot be empty")
                return false
            }
            fallthrough
        case .password:
            let viewModel = viewModels[row]
            if viewModel?.textValue.trimmed() == "" {
                view?.showErrorMessage(error: true, message: "Password cannot be empty")
                return false
            }
            fallthrough
        case .confirmPassword:
            let viewModel = viewModels[row]
            if viewModel?.textValue.trimmed() == "" || viewModels[.password]?.textValue != viewModels[.confirmPassword]?.textValue {
                view?.showErrorMessage(error: true, message: "Passwords do not match")
                return false
            }
        }

        return true
    }
}

extension RegistrationPresenter: GeneralRegistrationCellDelegate {
    func generalRegistrationCellDidChange(text: String?, indexPath: IndexPath?) {
        cellTextDidChange(text: text, index: indexPath)
    }
}
