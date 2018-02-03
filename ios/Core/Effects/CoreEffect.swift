import Foundation

enum CoreEffect: String, Codable {
    case presentEffect
    case removePresented
}

extension CoreEffect {
    var call: EffectFunc {
        switch self {
        case .presentEffect: return ios.presentEffect
        case .removePresented: return ios.removePresented
        }
    }
}
