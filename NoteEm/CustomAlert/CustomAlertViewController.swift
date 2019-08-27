//
//  CustomAlertViewController.swift
//  NoteEm
//
//  Created by Intern on 27/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var backgroundView: UIView!
    var confirmAction: (() -> Void)?
    var negationAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)

    }

    init(message: String, confirmAction: (() -> Void)? = nil, negationAction: (() -> Void)? = nil) {
        super.init(nibName: "CustomAlertViewController", bundle: nil)
        self.confirmAction = confirmAction
        self.negationAction = negationAction

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
