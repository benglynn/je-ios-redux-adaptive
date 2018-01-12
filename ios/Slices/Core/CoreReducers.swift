import Foundation

func updatePath (action: Actionable, slice: CoreStateSlice) -> CoreStateSlice {
    return slice
}

enum CoreReducer: String {
    case updatePathReducer
    // Adapters add core reducers here
    
    var reducer: Reducer<CoreStateSlice> {
        switch self {
        case .updatePathReducer:
            return updatePath
        }
    }
}

