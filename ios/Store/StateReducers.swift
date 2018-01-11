import Foundation

struct StateReducers {
    let core: [String: Reducer<CoreState>]
    let configuration: [String: Reducer<ConfigurationState>]
}

let initialStateReducers = StateReducers(
    core: coreReducers,
    configuration: configurationReducers
)
