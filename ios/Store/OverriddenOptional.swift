import Foundation

enum Optional<T> {
    case none
    case some(value: T)
}

func value<T>(from optionalOptional: Optional<T>?, or oldValue: T?) -> T? {
    if optionalOptional == nil {
        return oldValue
    }
    switch optionalOptional! {
    case .none: return nil
    case .some(let value): return value
    }
}
