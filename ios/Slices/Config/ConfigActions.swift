import Foundation

class UpdateIsAdaptedAction: Actionable {
    let type = Action.updateIsAdaptedAction
    let isAdapted: Bool
    
    init(_ nextIsAdapted: Bool) {
        self.isAdapted = nextIsAdapted
    }
}
