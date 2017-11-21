import UIKit

@objc extension UIColor {
    @objc public class func deletedColor() -> UIColor {
        return UIColor(red: 255, green: 0, blue: 0, alpha: 0.15)
    }

    @objc public class func strongDeletedColor() -> UIColor {
        return UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    }

    @objc public class func addedColor() -> UIColor {
        return UIColor(red: 0, green: 255, blue: 0, alpha: 0.15)
    }

    @objc public class func strongAddedColor() -> UIColor {
        return UIColor(red: 0, green: 255, blue: 0, alpha: 0.5)
    }
}
