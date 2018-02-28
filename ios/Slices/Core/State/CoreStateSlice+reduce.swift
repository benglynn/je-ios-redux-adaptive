import Foundation

extension CoreStateSlice {
    func reduce(_ action: Actionable) -> CoreStateSlice {
        if let reducer = self.reducers[action.type] {
            return reducer.call(self, action)
        }
        return self // TODO: return nil if no change
    }
}
