//
//  CustomAlertViewController.swift
//  NoteEm
//
//  Created by Intern on 27/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!

    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!

    // MARK: Variables
    var confirmAction: (() -> Void)?
    var negationAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }

    init(message: String, confirmAction: (() -> Void)? = nil, negationAction: (() -> Void)? = nil) {
        super.init(nibName: "CustomAlertViewController", bundle: nil)
        self.confirmAction = confirmAction
        self.negationAction = negationAction

    }

    override func viewDidLayoutSubviews() {
        confirmationButton.center.y += self.view.bounds.height
        denyButton.center.y -= self.view.bounds.height
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.confirmationButton.center.y -= self.view.bounds.height
            self.denyButton.center.y += self.view.bounds.height
        }, completion: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        confirmationButton.setTransparentUI(with: "Confirm")
        denyButton.setTransparentUI(with: "Cancel")
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    }

    // MARK: Callback
    @IBAction func confirmAction(_ sender: Any) {
      self.confirmAction?()

    }
    @IBAction func cancelAction(_ sender: Any) {
        guard let action = self.negationAction else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        action()
    }
}
