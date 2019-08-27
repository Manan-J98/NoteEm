//
//  NoteEmTests.swift
//  NoteEmTests
//
//  Created by Intern on 02/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import XCTest
@testable import NoteEm

class NoteEmTests: XCTestCase {

    func test_LoginPlaceholder() {
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        XCTAssertEqual("", loginViewController.usernameLabel.text!)
        XCTAssertEqual("", loginViewController.passwordLabel.text!)
    }
}
