import Foundation

let UPDATE_PATH = "Update path"

class UpdatePath: Actionable {
    let type = UPDATE_PATH
    let path: String
    
    init(_ path: String) {
        self.path = path
    }
}
