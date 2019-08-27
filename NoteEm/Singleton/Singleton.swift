//
//  Singleton.swift
//  NoteEm
//
//  Created by Intern on 08/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import Firebase

class Singleton {
    static let sharedInstance = Singleton()
    init() { }
    var db = Firestore.firestore()

    func updateCurrentUser(userId: String) {
        UserDefaults.standard.set(userId, forKey: "current_uid")
    }

    func encrypt(text: String) -> String {
        do {
            let sourceData = text.data(using: .utf8)!
            let password = "noteem"
            let salt = Data("6904CDEA".utf8)
            let iv = Data("642956B95ABF619E".utf8)
            let key = Data("hWmZq4t7w!z%C*F-JaNdRgUkXn2r5u8x".utf8)
            let aes = try AES256Crypter(key: key, iv: iv)
            let encryptedData = try aes.encrypt(sourceData)

            print("Encrypted hex string: \(String(describing: encryptedData.hexString()))")

            return encryptedData.hexString()

        } catch {
            print("Failed")
            print(error)
            return ""
        }
    }

    func decrypt(text: String) -> String {

        do {
            let sourceData = text.data(using: .utf8)!
            let iv = Data("5e9c7ee287981de7dc57cbddf36cdf26".utf8)
            let key = Data("5d259a9b52b0c2e55252dacdd5d302291c1d5961d9312236bb0084f73f0e8307".utf8)
            let aes = try AES256Crypter(key: key, iv: iv)
            let decryptedData = try aes.decrypt(sourceData)

            return decryptedData.hexString()
        }

        catch {
            print("Failed")
            return ""
        }
    }

}
