import Foundation

struct State {
    let core: CoreStateSlice
    // Adapters add slices below
}

extension State {
    init?(current: State, action: Actionable) {
        if action.type != Action.initState {
            self.init(
                core: current.core.reduce(with: action)
            )
        } else { self.init(core: initialCoreStateSlice) }
    }
}

