//
//  RegistrationViewController.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegistrationViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: NVActivityIndicatorView!

    // MARK: Variables
    var presenter: RegistrationPresenter!
    var coordinator: OnboardCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupTableView()
    }

    func startAnimating() {
        loader.startAnimating()
    }

    func stopAnimating() {
        loader.stopAnimating()
    }

    func setupPresenter() {
       self.presenter = RegistrationPresenter(registrationView: self)
       presenter.view = self
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "GeneralRegistrationCell", bundle: nil), forCellReuseIdentifier: "GeneralRegistrationCell")
    }

    @IBAction func registerAction(_ sender: Any) {
        self.view.endEditing(true)
        presenter.checkDataAndNavigate()
    }
}

// MARK: Tableview delegate and datasource
extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return presenter.getRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDataModel = presenter.viewModel(forRow: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegistrationCell") as? GeneralRegistrationCell else {
            fatalError("GeneralRegistrationCell not found")
        }
        cell.selectionStyle = .none
        cell.delegate = presenter
        cell.setupCellModel(viewModel: cellDataModel)
        return cell
    }
}

extension RegistrationViewController: RegistrationPresenterDelegate {
    func navigateToHome() {
        coordinator?.navigateToSuccessScreen()
    }

    func showErrorMessage(error: Bool, message: String) {
        self.showCustomAlert(error: error, message: message)
    }
}
