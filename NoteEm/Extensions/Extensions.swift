//
//  Extensions.swift
//  NoteEm
//
//  Created by Intern on 07/08/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension String {
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIViewController {
    
    func showCustomAlert(error: Bool, message: String) {
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true

        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = true

        // create a new style
        var style = ToastStyle()
        
        // this is just one of many style options
        style.messageColor = Color.whiteText.value
        style.backgroundColor = error ? Color.negation.value : Color.theme.value

        // present the toast with the new style

        DispatchQueue.main.async {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                window.makeToast(message, duration: 1.0, position: .bottom, style: style)
            }
        }
    }

}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        //swiftlint:disable force_cast
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        //swiftlint:enable force_cast
    }
}

extension UIButton {

    func setTransparentUI(with title: String) {
        let cornerRadius: CGFloat = 25.0
        self.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        self.layer.cornerRadius = cornerRadius
    }
}
