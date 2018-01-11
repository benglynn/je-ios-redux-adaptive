import Foundation

struct State {
    let core: CoreState
    let configuration: ConfigurationState
    // Adaptation slices add here
}

let initialState = State(
    core: initialCoreState,
    configuration: initialConfigurationState
    // Adaptation initial state added here
)

// TODO: this is a temporary struct, remove it once action/reducers are in place
let adaptedState = State(
    core: initialCoreState,
    configuration: adaptedConfigurationState
)

