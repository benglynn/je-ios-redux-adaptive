import Foundation

protocol Reducible {
    associatedtype SliceReducer
    var reducers: [Action: SliceReducer] { get }
    func reduce(_ action: Actionable) -> Self
}
