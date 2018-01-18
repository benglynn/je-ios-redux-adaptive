import Foundation

protocol StateSlice {
    associatedtype SliceReducer
    var _reducers: [Action: SliceReducer] { get }
    var _routes: [Route] { get }
    func reduce(with action: Actionable) -> Self
}
