//
//  HomeTableViewCell.swift
//  NoteEm
//
//  Created by Intern on 08/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

protocol HomeTableViewDelegate: class {
    func editUserNote(at cell: UITableViewCell)
    func removeUserNote(at cell: UITableViewCell)
}

struct HomeCellViewData {
    var dataValue: String
    var isEditable: Bool
    var isRemovable: Bool
    var isExpanded: Bool = false

    init(dataValue: String, isEditable: Bool, isRemovable: Bool) {
        self.dataValue = dataValue
        self.isEditable = isEditable
        self.isRemovable = isRemovable
    }
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var noteLabel: UILabel!

    weak var delegate: HomeTableViewDelegate?

    var viewModel: HomeCellViewData? {
        didSet {
            setupData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func editAction(_ sender: Any) {
        self.delegate?.editUserNote(at: self)
    }

    @IBAction func removeAction(_ sender: Any) {
        self.delegate?.removeUserNote(at: self)
    }

    func toggleExpansion() {
        self.noteLabel.numberOfLines = self.noteLabel.numberOfLines == 0 ? 1 : 0
        UIView.animate(withDuration: 5) {
            self.layoutIfNeeded()

        }
    }

    private func setupData() {
        guard let viewModel = self.viewModel else { return }
        noteLabel.text = viewModel.dataValue
        noteLabel.numberOfLines = viewModel.isExpanded ? 1 : 0
        editButton.isHidden = viewModel.isEditable
        removeButton.isHidden = viewModel.isRemovable
    }

    func setupCellData(viewModel: HomeCellViewData) {
        self.viewModel = viewModel
    }
}
