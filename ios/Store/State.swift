import Foundation

struct State {
    let core: CoreStateSlice
    // Adapters add slices here
}

extension State {
    init?(current: State, action: Actionable) {
//        print("Reduce state with \(action.description)")
        if action.type == Action.initState {
            self.init(core: initialCoreStateSlice)
        } else {
            let core = current.core.reduce(with: action)
            self.init(core: core)
        }
    }
}

let initialState = State(
    core: initialCoreStateSlice
)

