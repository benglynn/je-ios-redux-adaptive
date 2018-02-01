import Foundation

protocol Actionable {
    var type: Action { get }
    var description: String { get }
}

extension Actionable {
    var description: String {
        get { return type.rawValue }
    }
}
