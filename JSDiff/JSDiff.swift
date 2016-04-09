import UIKit
import JavaScriptCore

@objc public class JSLineDiff: NSObject {
    public let newLine: NSAttributedString
    public let oldLine: NSAttributedString

    init(oldLine: NSAttributedString, newLine: NSAttributedString) {
        self.oldLine = oldLine
        self.newLine = newLine
    }
}

@objc public class JSDiff: NSObject {
    let deletedColor: UIColor
    let deletedWordColor: UIColor
    let addedColor: UIColor
    let addedWordColor: UIColor
    private lazy var context: JSContext = {
        let context = JSContext()
        if let path = NSBundle(forClass: self.dynamicType).pathForResource("bundle", ofType: "js"), source = try? String(contentsOfFile: path) {
            context.evaluateScript(source)
        }
        return context
    }()

    public init(deletedColor: UIColor, deletedWordColor: UIColor, addedColor: UIColor, addedWordColor: UIColor) {
        self.deletedColor = deletedColor
        self.deletedWordColor = deletedWordColor
        self.addedColor = addedColor
        self.addedWordColor = addedWordColor
    }

    private func results(oldLine: String, newLine: String) -> [[String: AnyObject]] {
        let diff = context.objectForKeyedSubscript("swift_diffStrings")
        return diff.callWithArguments([oldLine, newLine]).toArray() as? [[String: AnyObject]] ?? []
    }

    @objc public func diffWords(oldLine: String, newLine: String) -> JSLineDiff {
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
