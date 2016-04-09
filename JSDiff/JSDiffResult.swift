import Foundation

struct JsDiffResult {
    let value: String
    let removed: Bool
    let added: Bool

    init?(dict: [String: AnyObject]) {
        guard let value = dict["value"] as? String else {
            return nil
        }
        self.value = value
        removed = dict["removed"] as? Bool ?? false
        added = dict["added"] as? Bool ?? false
    }
}
