//
//  HomeViewController.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol HomeViewType: class {
    func showErrorMessage(error: Bool, message: String)
    func reloadTable()
    func startAnimating()
    func stopAnimating()
    func updateData()
}

class HomeViewController: UIViewController, HomeViewType {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: NVActivityIndicatorView!

    // MARK: Variables
    var presenter: HomeViewPresenterType!
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = HomeViewPresenter(view: self)

        setupTableView()

        presenter.getUserNotes()

        setupNavigationView()
    }

    private func setupNavigationView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Notes", style: .plain, target: self, action: #selector(addUserNote))
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }

    @objc private func addUserNote() {
        let noteViewModel = NoteViewModel()
        noteViewModel.delegate = self
        coordinator?.navigateToAddUserNoteController(viewModel: noteViewModel, delegate: self)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }

    func startAnimating() {
        loader.startAnimating()
    }

    func stopAnimating() {
        loader.stopAnimating()
    }

    // MARK: Logout
    @IBAction func logoutAction(_ sender: Any) {
        coordinator?.customAppAlert(message: "Are you sure you want to logout?", confirmationHandler: {
            self.coordinator?.logout()
        })
    }

}

// MARK: Home View Type
extension HomeViewController {

    func updateData() {
         presenter.getUserNotes()
    }
    func showErrorMessage(error: Bool, message: String) {
        self.showCustomAlert(error: error, message: message)
    }

    func reloadTable() {
            self.tableView.reloadData()
    }
}

// MARK: Tableview delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.viewModel(forRow: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
            fatalError("HomeTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.setupCellData(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: Note View Delegate
extension HomeViewController: NoteViewDelegate {
    func userDidAddNote(notes: String) {
        presenter.userDidAddNotes(withText: notes)
    }

}

// MARK: Home Table View Cell Delegate
extension HomeViewController: HomeTableViewDelegate {
    func editUserNote(at cell: UITableViewCell) {
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        let index = tableView.indexPath(for: cell)
        self.coordinator?.navigateToEditUserNoteViewController(presenter: presenter.editUserNote(at: index!.row, text: cell.noteLabel.text!))
    }

    func removeUserNote(at cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        presenter.removeUserNote(at: indexPath.row)
    }
}
