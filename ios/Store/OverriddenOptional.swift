import Foundation

enum OverridenOptional<T> {
    case overridden(value: T)
    case nullified
}

func nextValue<T>(from overridenOptional: OverridenOptional<T>?, or oldValue: T?) -> T? {
    if overridenOptional == nil {
        return oldValue
    }
    switch overridenOptional! {
    case .nullified: return nil
    case .overridden(let value): return value
    }
}
