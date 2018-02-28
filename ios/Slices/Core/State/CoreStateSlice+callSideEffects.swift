import Foundation

extension CoreStateSlice {
    func callSideEffects(for action: Actionable, with latestState: State, store: Store) {
        if let effect = self.effects[action.type] {
            effect.call(store, latestState)
        }
    }
}
