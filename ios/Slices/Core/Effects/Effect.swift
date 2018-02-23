import Foundation

enum Effect: String, Codable {
    case presentScreensEffect
    case removePresented
}

extension Effect {
    var call: EffectFunc {
        switch self {
        case .presentScreensEffect: return ios.presentScreensEffect
        case .removePresented: return ios.removePresentedScreensEffect
        }
    }
}
