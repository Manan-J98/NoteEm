//
//  AddUserNotesViewController.swift
//  NoteEm
//
//  Created by Intern on 12/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

protocol AddUserNoteView: class {
    func showErrorMessage(error: Bool, message: String)
}

class AddUserNotesViewController: UIViewController, AddUserNoteView {

    // MARK: Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userNotes: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!

    weak var delegate: NoteViewDelegate?

    var presenter: AddUserNotePresenter!
    weak var viewModel: NoteViewModel?
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupView()

    }

    private func setupPresenter() {
        presenter = AddUserNotePresenter(addUserNoteView: self)
    }

    private func setupView() {
        self.cancelButton.setTransparentUI(with: "Cancel", cornerRadius: 5.0)
        self.confirmButton.setTransparentUI(with: "Confirm", cornerRadius: 5.0)
        bgView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    }

    func showErrorMessage(error: Bool, message: String) {
        self.showCustomAlert(error: error, message: message)
    }
    // MARK: Actions
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.userDidAddNote(notes: self.userNotes.text ?? "")

        }
    }
}
