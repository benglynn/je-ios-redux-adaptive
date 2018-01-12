import Foundation

typealias Reducer<S: StateSlice> = (_ stateSlice: S, _ action: Actionable) -> S




