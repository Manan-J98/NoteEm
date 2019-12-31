//
//  BaseViewController.swift
//  NoteEm
//
//  Created by Intern on 26/12/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var navBar: CustomNavigationView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupNavigationBar(isLeftButtonEnabled: Bool, navTitle: String, isRightButtonEnabled: Bool) {
        navBar = .fromNib()
        navBar?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: navBar?.bounds.height ?? 0.0)

        navBar?.navigationTitle.text = navTitle
        // left button
        if isLeftButtonEnabled {
            navBar?.leftButton.isHidden = false
        } else {
            navBar?.leftButton.isHidden = true
        }

        // right button
        if isRightButtonEnabled {
            navBar?.rightButton.isHidden = false
        } else {
            navBar?.rightButton.isHidden = true
        }
        self.view.addSubview(navBar!)

    }

}
