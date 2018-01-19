import Foundation

struct State {
    let core: CoreStateSlice
    // Adapters add slices here
}

extension State {
    init?(current: State, action: Actionable) {
        print("Init state with \(action.description)")
        let core = current.core.reduce(with: action)
        self.init(core: core)
    }
}

extension State {
    var _routes: [Route] {
        return core.routes
        // Adapters add (+) state routes here
    }
}

let initialState = State(
    core: initialCoreStateSlice
)

