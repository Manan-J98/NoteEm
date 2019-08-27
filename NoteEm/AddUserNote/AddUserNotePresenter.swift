//
//  AddUserNotePresenter.swift
//  NoteEm
//
//  Created by Intern on 12/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation

class AddUserNotePresenter {

    weak var addUserNoteView: AddUserNoteView?

    init(addUserNoteView: AddUserNoteView) {
        self.addUserNoteView = addUserNoteView
    }

    func addUserNote(viewModel: NoteViewModel?,text: String?) {
        viewModel?.dataValue = text ?? ""
    }
}
