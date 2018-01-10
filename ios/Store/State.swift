import Foundation

struct State {
    
    struct Core {
        let path: String
    }
    
    struct Config {
        let isAdapted: Bool
        let routes_: [(pathPattern: PathPattern, screens: [ScreenFamily])]
    }
    
    let core: Core
    let config: Config
    
}

let initialState = State(
    core: State.Core(
        path: ""
    ),
    config: State.Config(
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
    config: State.Config(
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

