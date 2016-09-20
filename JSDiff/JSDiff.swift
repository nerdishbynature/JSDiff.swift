import UIKit
import JavaScriptCore

@objc open class JSLineDiff: NSObject {
    open let newLine: NSAttributedString
    open let oldLine: NSAttributedString

    init(oldLine: NSAttributedString, newLine: NSAttributedString) {
        self.oldLine = oldLine
        self.newLine = newLine
    }
}

@objc open class JSDiff: NSObject {
    let deletedColor: UIColor
    let deletedWordColor: UIColor
    let addedColor: UIColor
    let addedWordColor: UIColor
    fileprivate lazy var context: JSContext = {
        let context = JSContext()
        if let path = Bundle(for: type(of: self)).path(forResource: "bundle", ofType: "js"), let source = try? String(contentsOfFile: path) {
            _ = context?.evaluateScript(source)
        }
        return context!
    }()

    public init(deletedColor: UIColor, deletedWordColor: UIColor, addedColor: UIColor, addedWordColor: UIColor) {
        self.deletedColor = deletedColor
        self.deletedWordColor = deletedWordColor
        self.addedColor = addedColor
        self.addedWordColor = addedWordColor
    }

    fileprivate func results(_ oldLine: String, newLine: String) -> [[String: AnyObject]] {
        let diff = context.objectForKeyedSubscript("swift_diffStrings")
        return diff!.call(withArguments: [oldLine, newLine]).toArray() as? [[String: AnyObject]] ?? []
    }

    @objc open func diffWords(_ oldLine: String, newLine: String) -> JSLineDiff {
        var oldLineIndex = 0
        var newLineIndex = 0
        let attributedOldLine = NSMutableAttributedString(string: oldLine)
        let attributedNewLine = NSMutableAttributedString(string: newLine)
        results(oldLine, newLine: newLine).map({ JsDiffResult(dict: $0) }).flatMap({ $0 }).forEach { result in
            let characterCount = result.value.characters.count
            if result.removed {
                attributedOldLine.addAttributes([NSBackgroundColorAttributeName: deletedWordColor], range: NSRange(location: oldLineIndex, length: characterCount))
            } else if result.added {
                attributedNewLine.addAttributes([NSBackgroundColorAttributeName: addedWordColor], range: NSRange(location: newLineIndex, length: characterCount))
            } else {
                attributedOldLine.addAttributes([NSBackgroundColorAttributeName: deletedColor], range: NSRange(location: oldLineIndex, length: characterCount))
                attributedNewLine.addAttributes([NSBackgroundColorAttributeName: addedColor], range: NSRange(location: newLineIndex, length: characterCount))
            }

            if result.removed {
                oldLineIndex += characterCount
            } else if result.added {
                newLineIndex += characterCount
            } else {
                oldLineIndex += characterCount
                newLineIndex += characterCount
            }
        }
        return JSLineDiff(oldLine: attributedOldLine, newLine: attributedNewLine)
    }
}
