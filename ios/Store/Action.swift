import Foundation

protocol Actionable {
    var description: String { get }
}

extension Actionable {
    var description: String {
        get { return String(describing: type(of: self)) }
    }
}

class InitialAction: Actionable {}


