import Foundation

struct State {
    let core: CoreStateSlice
    // Adapters add slices below
}

extension State {
    init?(current: State, action: Actionable, store: Store) { // TODO: nil if nothing changed
        if action.type != Action.initState {
            self.init(
                core: current.core.reduce(action)
            )
        } else {
            self.init(
                core: initialCoreStateSlice
            )
        }
    }
}

extension State {
    func callSideEffects(for action: Actionable, store: Store) {
        self.core.callSideEffects(for: action, with: self, store: store)
    }
}

