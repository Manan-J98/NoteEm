//
//  HomeViewPresenter.swift
//  NoteEm
//
//  Created by Intern on 08/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import Firebase

protocol HomeViewPresenterType {
    func viewModel(forRow index: Int) -> HomeCellViewData
    func getRows() -> Int
    func getUserNotes()
    func userDidAddNotes(withText text: String)
    func editUserNote(at index: Int, text: String) -> EditUserNotePresenter
    func removeUserNote(at index: Int)
    func didSelect(row index: Int)
}

class HomeViewPresenter: HomeViewPresenterType {

    private weak var view: HomeViewType?

    init(view: HomeViewType) {
        self.view = view
    }

    private var rowCount: Int = 0

    private var rowData: [String] = [] {
        didSet {
            self.updateCellModel()
        }
    }

    private var cellModels = [HomeCellViewData]()

    func viewModel(forRow index: Int) -> HomeCellViewData {
        return cellModels[index]
    }

    func getRows() -> Int {
        return rowCount
    }

    func didSelect(row index: Int) {
        cellModels[index].isExpanded.toggle()
    }

    func getUserNotes() {

        let currentUser = getCurrentUserWithId()
        self.view?.startAnimating()
        currentUser.getDocument { (user, error) in
            self.view?.stopAnimating()
            if let error = error {
                debugPrint(error)
                self.view?.showErrorMessage(error: true, message: error.localizedDescription)
            } else {
                if let currentData = user?.data(), let prevNotes = currentData["note"] as? [String] {
                    self.rowCount = prevNotes.count
                    self.rowData = prevNotes
                    self.updateCellModel()
                }
            }
        }
    }

    private func updateCellModel() {
        cellModels = rowData.map {
            HomeCellViewData(dataValue: $0, isEditable: false, isRemovable: false)
        }
        self.view?.reloadTable()
    }

    private func getCurrentUserWithId() -> DocumentReference {

        guard let currentUserId = UserDefaults.standard.value(forKey: "current_uid") as? String else {
            fatalError("User Not Found")
        }
        let currentUser = Singleton.sharedInstance.db.collection("users").document(currentUserId)
        return currentUser
    }

    func removeUserNote(at index: Int) {

        self.view?.startAnimating()

        let currentUser = getCurrentUserWithId()

        // MARK: API HIT
        currentUser.getDocument { (user, error) in
            self.view?.stopAnimating()
            if let error = error {
                self.view?.showErrorMessage(error: true, message: error.localizedDescription)
            } else {
                if var newData = user?.data(), var currentNotes = newData["note"] as? [String] {
                    currentNotes.remove(at: index)
                    self.rowCount = currentNotes.count
                    self.rowData = currentNotes
                    newData["note"] = currentNotes
                    currentUser.setData(newData, completion: { (error) in
                        if let error = error {
                            self.view?.showErrorMessage(error: true, message: error.localizedDescription)
                        } else {
                            self.view?.reloadTable()
                        }
                    })
                }
            }

        }
    }

    func editUserNote(at index: Int, text: String) -> EditUserNotePresenter {
        let presenter = EditUserNotePresenter(index: index, text: text)
        presenter.delegate = self
        return presenter
    }

    func userDidAddNotes(withText text: String) {

        let currentUser = getCurrentUserWithId()
        currentUser.getDocument { (user, error) in
            if let error = error {
                debugPrint(error)
                self.view?.showErrorMessage(error: true, message: error.localizedDescription)
            } else {
                if var newData = user?.data(), var prevNote = newData["note"] as? [String] {
                    prevNote.append(text)
                    newData["note"] = prevNote
                    self.view?.startAnimating()
                    currentUser.setData(newData, completion: { (error) in
                        self.view?.stopAnimating()
                        if let error = error {
                            self.view?.showErrorMessage(error: true, message: error.localizedDescription)
                        } else {
                            self.getUserNotes()
                        }
                    })
                }
            }

        }
    }
}

extension HomeViewPresenter: EditUserNoteViewDelegate {
    func updateData() {
        self.view?.updateData()
    }

}
