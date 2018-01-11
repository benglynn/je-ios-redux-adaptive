import Foundation

func pathCoreReducer (action: Actionable, slice: State.Core) -> State.Core {
    return slice
}


let coreReducers: [String: Reducer<State.Core>] = [
    "pathCoreReducer": pathCoreReducer
]
