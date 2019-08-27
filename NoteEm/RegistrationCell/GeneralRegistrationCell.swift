//
//  GeneralRegistrationCell.swift
//  NoteEm
//
//  Created by Intern on 06/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

protocol GeneralRegistrationCellDelegate: class {
    func generalRegistrationCellDidChange(text:String?, indexPath: IndexPath?)
}

struct GeneralTextViewModel {
    var indexPath: IndexPath?
    var placeholder: String
    var textValue: String
    var isSecureText: Bool
    
    init(placeholder: String, textValue: String, isSecureText: Bool) {
        self.placeholder = placeholder
        self.textValue = textValue
        self.isSecureText = isSecureText
    }
}

class GeneralRegistrationCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var generalTextField: UITextField!

    // MARK: Variables
    weak var delegate: GeneralRegistrationCellDelegate?

    var viewModel: GeneralTextViewModel? {
        didSet {
            self.setupData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.generalTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCellModel(viewModel: GeneralTextViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupData() {
        guard let viewModel = self.viewModel else { return }
        self.generalTextField.text = viewModel.textValue
        self.generalTextField.isSecureTextEntry = viewModel.isSecureText
        self.placeholder.text = viewModel.placeholder
    }
}

// MARK: UITextField delegate

extension GeneralRegistrationCell: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.generalRegistrationCellDidChange(text: textField.text, indexPath: self.viewModel?.indexPath)
    }
}
