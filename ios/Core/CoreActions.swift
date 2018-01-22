import Foundation

struct InitialAction: Actionable {
    let type = Action.initialAction
}

struct ActivateAdaptation: Actionable {
    let type: Action
}

struct DismissLastAction: Actionable {
    let type = Action.dismissLastAction
}

struct UpdatePathAction: Actionable {
    let type = Action.updatePathAction
    let path: String
}

struct UpdateIsAdaptedAction: Actionable {
    let type = Action.updateIsAdaptedAction
    let isAdapted: Bool
}

struct ResetAction: Actionable {
    let type = Action.resetAction
}

struct initStateAction: Actionable {
    let type = Action.initState
}
