import Foundation

struct State {
    
    struct Core {
        let path: String
    }
    
    struct Configuration {
        let isAdapted: Bool
        let routes_: [(pathPattern: PathPattern, screens: [ScreenFamily])]
    }
    
    let core: Core
    let configuration: Configuration
    
}

struct StateReducers {
    let core: [String: Reducer<State.Core>]
    let configuration: [String: Reducer<State.Configuration>]
}

let initialStateReducers = StateReducers(
    core: coreReducers,
    configuration: configurationReducers
)

let initialState = State(
    core: State.Core(
        path: ""
    ),
    configuration: State.Configuration(
        isAdapted: false,
        routes_: [
            (pathPattern: .HomePath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home]),
                ScreenFamily(screen: .Home, children: nil),
                ]),
            ( pathPattern: .AreaPath,
              screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ]),
            (pathPattern: .OrdersPath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Orders, children: nil),
                ]),
            (pathPattern: .SettingsPath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Settings, children: nil),
                ])
        ]
    )
)

// TODO: this is a temporary struct, remove it once action/reducers are in place
let adaptedState = State(
    core: State.Core(
        path: ""
    ),
    configuration: State.Configuration(
        isAdapted: true,
        routes_: [
            (pathPattern: .HomePath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home]),
                ScreenFamily(screen: .Home, children: nil),
                ]),
            ( pathPattern: .AreaPath,
              screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ]),
            (pathPattern: .OrdersPath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Orders, children: nil),
                ]),
            (pathPattern: .SettingsPath,
             screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Settings, children: nil),
                ])
        ]
    )
)

