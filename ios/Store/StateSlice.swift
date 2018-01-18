import Foundation

protocol StateSlice {
    associatedtype SliceReducer
    var _reducers: [Action: SliceReducer] { get }
    func reduce(with action: Actionable) -> Self
}
