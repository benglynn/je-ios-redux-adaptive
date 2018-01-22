import Foundation

struct UpdatePathAction: Actionable {
    let type: Action = Action.updatePathAction
    let path: String
}

struct UpdateIsAdaptedAction: Actionable {
    let type = Action.updateIsAdaptedAction
    let isAdapted: Bool
}
