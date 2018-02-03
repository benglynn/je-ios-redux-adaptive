import Foundation

enum Effect: String, Codable {
    case presentEffect
    case removePresented
}

extension Effect {
    var call: EffectFunc {
        switch self {
        case .presentEffect: return ios.presentEffect
        case .removePresented: return ios.removePresented
        }
    }
}
