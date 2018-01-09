import Foundation

struct State {
    
    struct Core {
        let path: String
    }
    
    struct Config {
        let isAdapted: Bool
        let routes: [Screen: Route]
        let routes_: [Path: [ScreenFamily]]
    }
    
    let core: Core
    let config: Config
    
}

enum Path: String {
    case HomePath = "^$"
    case OrdersPath = "^orders$"
    case SettingsPath = "^settings$"
    case AreaPath = "^bs14dj$" // TODO: postcode regex
}

struct ScreenFamily {
    let screen: Screen
    let children: [Screen]?
}

let initialState = State(
    core: State.Core(
        path: ""
    ),
    config: State.Config(
        isAdapted: false,
        routes: [
            .HomeScreen: Route(pattern: "^$", parents: [
                .RestaurantsScreen: [.HomeScreen],
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ]),
            .OrdersScreen: Route(pattern: "^orders$", parents: [
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ]),
            .SettingsScreen: Route(pattern: "^settings$", parents: [
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ])
        ],
        // TODO: refactor around this structure
        routes_: [
            .HomePath: [
                ScreenFamily(screen: .HomeScreen, children: nil),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen]),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .AreaPath: [
                ScreenFamily(screen: .AreaScreen, children: nil),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen, .AreaScreen]),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .OrdersPath: [
                ScreenFamily(screen: .OrdersScreen, children: nil),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .SettingsPath: [
                ScreenFamily(screen: .SettingsScreen, children: nil),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ]
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
        routes: [
            .HomeScreen: Route(pattern: "^$", parents: [
                .RestaurantsScreen: [.HomeScreen],
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ]),
            .OrdersScreen: Route(pattern: "^orders$", parents: [
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ]),
            .SettingsScreen: Route(pattern: "^settings$", parents: [
                .TabsScreen: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen]
                ])
        ],
        routes_: [
            .HomePath: [
                ScreenFamily(screen: .HomeScreen, children: nil),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen]),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .AreaPath: [
                ScreenFamily(screen: .AreaScreen, children: nil),
                ScreenFamily(screen: .RestaurantsScreen, children: [.HomeScreen, .AreaScreen]),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .OrdersPath: [
                ScreenFamily(screen: .OrdersScreen, children: nil),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ],
            .SettingsPath: [
                ScreenFamily(screen: .SettingsScreen, children: nil),
                ScreenFamily(screen: .TabsScreen, children: [.RestaurantsScreen, .OrdersScreen, .SettingsScreen])
            ]
        ]
    )
)


