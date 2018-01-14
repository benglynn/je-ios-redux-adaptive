import Foundation

class UpdatePathAction: Actionable {
    let type = Action.updatePathAction
    let path: String
    
    init(_ path: String) {
        self.path = path
    }
}
