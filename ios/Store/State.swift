import Foundation

struct State {
    let core: CoreStateSlice
    let area: SearchStateSlice
    // Adapters add slices below
}

extension State {
    init?(current: State, action: Actionable, store: Store) { // TODO: nil if nothing changed
        if action.type == Action.initStateAction {
            self.init(
                core: initialCoreStateSlice,
                area: initialSearchStateSlice
            )
        } else {
            self.init(
                core: current.core.reduce(action),
                area: current.area.reduce(action)
            )
        }
    }
}

extension State {
    func callSideEffects(for action: Actionable, store: Store) {
        self.core.callSideEffects(for: action, with: self, store: store)
    }
}

