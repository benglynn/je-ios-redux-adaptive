import Foundation

typealias Reducer<S: Reducible> = (_ stateSlice: S, _ action: Actionable) -> S




