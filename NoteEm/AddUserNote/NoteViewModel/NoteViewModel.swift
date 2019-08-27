//
//  NoteViewModel.swift
//  NoteEm
//
//  Created by Intern on 14/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
protocol NoteViewDelegate: class {
    func userDidAddNote(notes: String)
}

class NoteViewModel {
    var dataValue = String()
    var delegate: NoteViewDelegate?
}
