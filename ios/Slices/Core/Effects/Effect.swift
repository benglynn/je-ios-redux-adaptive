import Foundation

enum Effect: String, Codable {
    case presentRouteEffect
    case presentScreensEffect
    case removePresented
    case searchEffect
}

extension Effect {
    var call: EffectFunc {
        switch self {
        case .presentRouteEffect: return ios.presentRouteEffect
        case .presentScreensEffect: return ios.presentScreensEffect
        case .removePresented: return ios.removePresentedScreensEffect
        case .searchEffect: return ios.searchEffect
        }
    }
}
