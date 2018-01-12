import Foundation

class UpdatePath: Actionable {
    let type = Action.updatePathAction
    let path: String
    
    init(_ path: String) {
        self.path = path
    }
}
