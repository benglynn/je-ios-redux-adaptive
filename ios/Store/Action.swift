import Foundation

enum Action: String, Codable {
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
