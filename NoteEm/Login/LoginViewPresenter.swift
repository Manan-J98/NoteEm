//
//  LoginViewPresenter.swift
//  NoteEm
//
//  Created by Intern on 12/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewPresenter {

    var loginView: LoginView?

    init() {

    }

    func authenticateUser(username: String, password: String, completion: ((_ user: AuthDataResult?, _ error: Error?) -> Void)?) {
        loginView?.startAnimating()
        let encryptedPassword = Singleton.sharedInstance.encrypt(text: password)
        Auth.auth().signIn(withEmail: username, password: encryptedPassword) { (user, error) in
            self.loginView?.stopAnimating()
            completion!(user, error)
            if let error = error {
                print(error)
                self.loginView?.showErrorMessage(error: true, message: error.localizedDescription)
                return
            }
            Singleton.sharedInstance.updateCurrentUser(userId: user!.user.uid)
            self.loginView?.loginSuccessfull()
        }
    }
}
