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
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen]),
                ScreenFamily(screen: .HomeScreen, children: nil),
                ]),
            ( pathPattern: .AreaPath,
              screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen, .AreaScreen]),
                ScreenFamily(screen: .AreaScreen, children: nil),
                ]),
            (pathPattern: .OrdersPath,
             screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .OrdersScreen, children: nil),
                ]),
            (pathPattern: .SettingsPath,
             screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .SettingsScreen, children: nil),
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
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen]),
                ScreenFamily(screen: .HomeScreen, children: nil),
                ]),
            ( pathPattern: .AreaPath,
              screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen, .AreaScreen]),
                ScreenFamily(screen: .AreaScreen, children: nil),
                ]),
            (pathPattern: .OrdersPath,
             screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .OrdersScreen, children: nil),
                ]),
            (pathPattern: .SettingsPath,
             screens: [
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]),
                ScreenFamily(screen: .SettingsScreen, children: nil),
                ])
        ]
    )
)

