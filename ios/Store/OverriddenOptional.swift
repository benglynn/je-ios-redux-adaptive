import Foundation

enum Optional<T> {
    case noValue
    case value(value: T)
}

func value<T>(from optionalOptional: Optional<T>?, or oldValue: T?) -> T? {
    if optionalOptional == nil {
        return oldValue
    }
    switch optionalOptional! {
    case .noValue: return nil
    case .value(let value): return value
    }
}
