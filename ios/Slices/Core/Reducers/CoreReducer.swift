import Foundation

enum CoreReducer: String, Codable {
    case updateIsAdaptedReducer
    case presentResetScreenReducer
    case updatePathReducer
    case dismissLastScreenFamilyReducer
    // Adapters add core reducers below
    case activateMenuAdaptationReducer
    case presentMenuReducer
}

extension CoreReducer {
    var call: ReducerFunc<CoreStateSlice> {
        switch self {
        case .updateIsAdaptedReducer: return ios.updateIsAdaptedReducer
        case .presentResetScreenReducer: return ios.presentResetScreenReducer
        case .updatePathReducer: return ios.updatePathReducer
        case .dismissLastScreenFamilyReducer: return ios.dismissLastScreenFamilyReducer
        case .activateMenuAdaptationReducer: return ios.activateMenuAdaptationReducer
        case .presentMenuReducer: return ios.presentMenuReducer
        }
    }
}

