//
//  EditUserNotePresenter.swift
//  NoteEm
//
//  Created by Intern on 22/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation

protocol EditUserNoteViewDelegate: class {
    func updateData()
}

protocol EditUserNoteDelegate: class {
    func setText(currentText: String)
    func showErrorMessage(error: Bool, message: String)
    func updationSuccess()
    func startAnimating()
    func stopAnimating()
}

class EditUserNotePresenter {

//    var editUserNoteView: EditUserNoteViewController

    var index: Int?
    var currentText: String? {
        didSet {
            self.setCurrentText(currentText: self.currentText!)
        }
    }

    weak var editView: EditUserNoteDelegate?
    weak var delegate: EditUserNoteViewDelegate?

    init(index: Int?, text: String?) {
        self.index = index
        self.currentText = text
    }

    private func setCurrentText(currentText: String) {
        editView?.setText(currentText: currentText)
    }

    func updateUserNote(index: Int, data: String) {
        self.editView?.startAnimating()
        guard let currentUserId = UserDefaults.standard.value(forKey: "current_uid") as? String else {
            fatalError("User Not Found")
        }
        let currentUser = Singleton.sharedInstance.db.collection("users").document(currentUserId)
        currentUser.getDocument { (user, error) in
            if let error = error {
                self.editView?.showErrorMessage(error: true, message: error.localizedDescription)
            } else {
                if var newData = user?.data(), var currentNotes = newData["note"] as? [String] {
                    currentNotes[index] = data
                    newData["note"] = currentNotes
                    currentUser.setData(newData) { (error) in
                        if let error = error {
                            self.editView?.stopAnimating()

                            self.editView?.showErrorMessage(error: true, message: error.localizedDescription)
                        } else {
                            self.delegate?.updateData()
                            self.editView?.updationSuccess()
                        }
                    }
                }
            }
        }
    }
}
