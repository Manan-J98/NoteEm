import Foundation
import UIKit

enum Color {
    case switchGreen
    case theme
    case secondaryTheme
    case clear
    case border
    case shadow
    case lightborder

    case darkBackground
    case lightBackground
    case semiLightBackground
    case intermidiateBackground

    case blackText
    case darkText
    case semiDarkLight
    case semiLight
    case mediumLight
    case intermidiateText
    case lightText
    case whiteText
    case mediumGray
    case themeButtonText

    case textFieldTitle
    case textFieldPlaceHolder

    case extraLight

    case affirmation
    case negation

    case facebook

    // 1
    case custom(hexString: String, alpha: Double)
    // 2
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }

    case pendingStatusBackground
    case detailsButton
    case accept
    case reject
    case gradienttop
    case gradientbtm
    case bgNoti
}

extension Color {
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .border:
            instanceColor = UIColor(hexString: "#000000")
        case .clear:
            instanceColor = UIColor.clear
        case .theme:
            instanceColor = UIColor(hexString: "#000000")
        case .secondaryTheme:
            instanceColor = UIColor(red: 241/255, green: 130/255, blue: 0/255, alpha: 1.0)

        case .shadow:
            instanceColor = UIColor(hexString: "#cccccc")
        case .lightborder:
            instanceColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)

        case .darkBackground:
            instanceColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        case .semiLightBackground:
            instanceColor = UIColor.init(white: 237/255, alpha: 1.0)//UIColor(hexString: "#ededed")
        case .lightBackground:
            instanceColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        case .intermidiateBackground:
            instanceColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).withAlphaComponent(0.6)

        case .blackText:
            instanceColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        case .darkText:
            instanceColor = UIColor(red: 35/255, green: 39/255, blue: 53/255, alpha: 1.0)
        case .semiDarkLight:
            instanceColor = UIColor(red: 95/255, green: 95/255, blue: 95/255, alpha: 1.0)
        case .semiLight:
            instanceColor = UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1.0)
        case .mediumLight:
            instanceColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
        case .intermidiateText:
            instanceColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        case .extraLight:
            instanceColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
        case .lightText:
            instanceColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        case .whiteText:
            instanceColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)

        case .themeButtonText:
            instanceColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)

        case .textFieldTitle:
            instanceColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
        case .textFieldPlaceHolder:
            instanceColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)

        case .affirmation:
            instanceColor = Color.theme.value
        //UIColor(red: 37/255, green: 174/255, blue: 136/255, alpha: 1.0)
        case .negation:
            instanceColor = UIColor(red: 217/255, green: 51/255, blue: 51/255, alpha: 1.0)

        case .facebook:
            instanceColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)

        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))

        case .pendingStatusBackground:
            instanceColor = UIColor(red: 225/255, green: 140/255, blue: 38/255, alpha: 1.0)
        case .detailsButton:
            instanceColor = UIColor(red: 235/255, green: 129/255, blue: 2/255, alpha: 1.0)
        case .accept:
            instanceColor = UIColor(red: 37/255, green: 174/255, blue: 136/255, alpha: 1.0)
        case .reject:
            instanceColor = UIColor(red: 236/255, green: 85/255, blue: 101/255, alpha: 1.0)
        case .switchGreen:
            instanceColor = UIColor(red: 102/255, green: 159/255, blue: 72/255, alpha: 1.0)
        case .mediumGray:
            instanceColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        case .gradienttop:
            instanceColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)

        case .gradientbtm:
            instanceColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.0)
        case .bgNoti:
            instanceColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)

        }
        return instanceColor
    }
}

extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let redColor = Int(color >> 16) & mask
        let greenColor = Int(color >> 8) & mask
        let blueColor = Int(color) & mask
        let red   = CGFloat(redColor) / 255.0
        let green = CGFloat(greenColor) / 255.0
        let blue  = CGFloat(blueColor) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
