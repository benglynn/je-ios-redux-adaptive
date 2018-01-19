import Foundation

protocol StateSlice {
    associatedtype SliceReducer
    var reducers: [Action: SliceReducer] { get }
    func reduce(with action: Actionable) -> Self
}
