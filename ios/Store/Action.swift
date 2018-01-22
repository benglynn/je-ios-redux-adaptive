import Foundation

enum Action: String {
    case initialAction
    case updatePathAction
    case updateIsAdaptedAction
    // Adapters add actions below
    case activateMenuAdaptationAction
    case presentMenu
    case dismissMenu
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

struct InitialAction: Actionable {
    let type: Action = Action.initialAction
}

struct ActivateAdaptation: Actionable {
    let type: Action
}
