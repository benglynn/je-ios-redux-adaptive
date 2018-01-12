import Foundation

protocol StateSlice {
    func reduce(current: State, with action: Actionable) -> Self
}
