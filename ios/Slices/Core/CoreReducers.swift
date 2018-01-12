import Foundation

func updatePathReducer (action: Actionable, slice: CoreStateSlice) -> CoreStateSlice {
    return slice
}

enum CoreReducer: String {
    case updatePath
    // Adapters add core reducers here
    
    var reducer: Reducer<CoreStateSlice> {
        switch self {
        case .updatePath:
            return updatePathReducer
        }
    }
}

