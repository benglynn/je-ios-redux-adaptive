import Foundation

struct State {
    let core: CoreState
    let configuration: ConfigurationState
    // Adapters add slices here
}

extension State {
    init?(old: State, action: Actionable) {
        print("Creating state with \(action.description) action")
        let core = old.core
        let configuration = old.configuration
        self.init(core: core, configuration: configuration)
    }
    
    func reduceSlice<T>(slice: T, action: Actionable, reducers: [Reducer<T>]) -> T {
        return slice
    }
}



let initialState = State(
    core: initialCoreState,
    configuration: initialConfigurationState
)

// TODO: this is a temporary struct, remove it once action/reducers are in place
let adaptedState = State(
    core: initialCoreState,
    configuration: adaptedConfigurationState
)

