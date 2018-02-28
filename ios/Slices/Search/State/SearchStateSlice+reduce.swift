import Foundation

extension SearchStateSlice {
    func reduce(_ action: Actionable) -> SearchStateSlice {
        if let reducer = self.reducers[action.type] {
            return reducer.call(self, action)
        }
        return self // TODO: return nil if no change
    }
}
