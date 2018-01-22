import Foundation

enum Action: String {
    case initialAction
    case updatePathAction
    case updateIsAdaptedAction
    case dismissLastAction
    case resetAction
    case initState
    // Adapters add actions below
    case activateMenuAdaptationAction
    case presentMenu
}

protocol Actionable {
    var type: Action { get }
    var description: String { get }
}

extension Actionable {
    var description: String {
        get { return type.rawValue }
    }
}
