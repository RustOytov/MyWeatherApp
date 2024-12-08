import Foundation
import UIKit

enum rubikType: String {
    case regular = "Rubik-VariableFont_wght"
    case bold = "Rubik-Bold"
    case medium = "Rubik-Medium"
    case light = "Rubik-Light"
}

extension UIFont{
    static func rubik(fontType: rubikType = .regular, size: CGFloat = 16) -> UIFont{
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
