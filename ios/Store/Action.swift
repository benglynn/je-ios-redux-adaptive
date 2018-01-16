import Foundation

enum Action: String {
    case initialAction
    case updatePathAction
    case updateIsAdaptedAction
    // Adapters add actions below
    case activateMenuAdaptationAction
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

class InitialAction: Actionable {
    let type = Action.initialAction
}

