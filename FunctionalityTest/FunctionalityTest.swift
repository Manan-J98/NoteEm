//
//  FunctionalityTest.swift
//  FunctionalityTest
//
//  Created by Intern on 21/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import XCTest
@testable import NoteEm
import Firebase
class FunctionalityTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        print("Method: 1")
    }

    override func setUp() {
        super.setUp()
        print("Method: 2")

    }

    func test_loginSuccess() {
        let presenter = LoginViewPresenter()
        let expectation = XCTestExpectation(description: "Login Successfull")

        presenter.authenticateUser(username: "manan@yopmai.com", password: "qwerty") { (user,error) in
            print("/////////////////////",error)
            XCTAssertNil(user)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_zaccessTokenLogin() {
        print("Method: 3")
        let oas = UserDefaults.standard.string(forKey: "accesstoken")
        XCTAssertEqual("654321", oas)
    }

    func test_bLogin() {
        //API Hit
        //Response accesstoken
        print("Method: 4")
        UserDefaults.standard.set("123456", forKey: "accesstoken")

        let oas = UserDefaults.standard.string(forKey: "accesstoken")
        UserDefaults.standard.set("654321", forKey: "accesstoken")

        XCTAssertEqual("123456", oas)
    }

//    func test_checkAccessToken() {
//        print("Method: 5")
//        let oas = UserDefaults.standard.string(forKey: "accesstoken")
//        XCTAssertEqual(nil, oas)
//    }

    override  func tearDown() {
        super.tearDown()
        print("Method: 6")
    }

    override class func tearDown() {
        super.tearDown()
        print("Method: 7")
        UserDefaults.standard.set(nil, forKey: "accesstoken")
    }

//    func test_Logout() {
//        //API Hit
//        // Logout
////        UserDefaults.standard.set(nil, forKey: "accesstoken")
//        let oas = UserDefaults.standard.string(forKey: "accesstoken")
//        XCTAssertEqual(nil, oas)
//    }

}
