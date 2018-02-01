import Foundation

struct UpdatePathAction: Actionable {
    let type = Action.updatePathAction
    let path: String
}
