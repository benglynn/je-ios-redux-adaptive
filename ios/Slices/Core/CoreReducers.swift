import Foundation

func updatePathReducer (action: Actionable, slice: CoreState) -> CoreState {
    return slice
}

enum CoreReducer: String {
    case updatePath
    // Adapters add core reducers here
    
    var reducer: Reducer<CoreState> {
        switch self {
        case .updatePath:
            return updatePathReducer
        }
    }
}

