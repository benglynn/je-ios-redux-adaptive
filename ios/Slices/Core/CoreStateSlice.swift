import Foundation

struct CoreStateSlice: StateSlice {
    let path: String
    
    func reduce(current: State, with action: Actionable) -> CoreStateSlice {
        if let reducer = current.config.core.reducers[action.type] {
            return reducer.reduce(current.core, action)
        }
        return current.core
    }
}

let initialCoreStateSlice = CoreStateSlice(
    path: ""
)
