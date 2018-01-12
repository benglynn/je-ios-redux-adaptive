import Foundation

struct State {
    let core: CoreStateSlice
    let config: ConfigStateSlice
    // Adapters add slices here
}

extension State {
    init?(current: State, action: Actionable) {
        print("Init state with \(action.description)")
        let core = current.core.reduce(current: current, with: action)
        let configuration = current.config.reduce(current: current, with: action)
        self.init(core: core, config: configuration)
    }
}

let initialState = State(
    core: initialCoreStateSlice,
    config: initialConfigStateSlice
)

// TODO: this is a temporary struct, remove it once action/reducers are in place
let adaptedState = State(
    core: initialCoreStateSlice,
    config: adaptedConfigStateSlice
)

