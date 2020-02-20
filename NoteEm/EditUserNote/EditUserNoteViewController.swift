//
//  EditUserNoteViewController.swift
//  NoteEm
//
//  Created by Intern on 22/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EditUserNoteViewController: UIViewController, EditUserNoteDelegate {

    var presenter: EditUserNotePresenter!
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPresenter()
    }

    private func setupViews() {
        self.updateButton.setTransparentUI(with: "Update")
        self.navigationController?.isNavigationBarHidden = true
        self.noteTextView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
    }

    private func setupPresenter() {
        presenter.editView = self
        self.setupData()
    }

    private func setupData() {
        self.noteTextView.text = presenter.currentText
        self.title = "Update"
    }

    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var loader: NVActivityIndicatorView!

    @IBAction func updateAction(_ sender: Any) {
        presenter.updateUserNote(index: presenter.index!, data: noteTextView.text)
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func showErrorMessage(error: Bool, message: String) {
        self.showCustomAlert(error: true, message: message)
    }

    func setText(currentText: String) {
        self.noteTextView.text = currentText
    }

    func updationSuccess() {
        self.navigationController?.popViewController(animated: true)
    }

    func startAnimating() {
        loader.startAnimating()
    }

    func stopAnimating() {
        loader.stopAnimating()
    }

}
