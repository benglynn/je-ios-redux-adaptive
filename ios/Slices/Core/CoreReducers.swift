import Foundation

func pathCoreReducer (action: Actionable, slice: CoreState) -> CoreState {
    return slice
}


let coreReducers: [String: Reducer<CoreState>] = [
    "pathCoreReducer": pathCoreReducer
]
