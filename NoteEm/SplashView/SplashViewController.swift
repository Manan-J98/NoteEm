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

    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
//        appLogo.layer.add(getRotation(), forKey: "rotationAnimation")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
//        self.appLogo.layer.removeAllAnimations()
    }
//
//    func getRotation() -> CABasicAnimation {
//        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotation.toValue = Double.pi * 2
//        rotation.duration = 10 // or however long you want ...
//        rotation.isCumulative = true
//        rotation.repeatCount = Float.greatestFiniteMagnitude
//        return rotation
//    }

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
