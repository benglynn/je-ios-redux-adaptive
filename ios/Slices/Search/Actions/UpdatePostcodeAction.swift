
import Foundation

struct UpdatePostcodeAction: Actionable {
    let type = Action.updatePostcodeAction
    let postcode: String?
}
