import Foundation

typealias ReducerFunc<S: Reducible> = (_ stateSlice: S, _ action: Actionable) -> S




