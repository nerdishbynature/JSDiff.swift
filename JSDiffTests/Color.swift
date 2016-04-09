import UIKit

extension UIColor {
    public class func deletedColor() -> UIColor {
        return UIColor(red: 255, green: 0, blue: 0, alpha: 0.15)
    }
    public class func strongDeletedColor() -> UIColor {
        return UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    }
    public class func addedColor() -> UIColor {
        return UIColor(red: 0, green: 255, blue: 0, alpha: 0.15)
    }

    public class func strongAddedColor() -> UIColor {
        return UIColor(red: 0, green: 255, blue: 0, alpha: 0.5)
    }
}
