import Foundation

struct State {
    
    struct Core {
        let path: String
    }
    
    struct Config {
        let isAdapted: Bool
        let routes: [StoryboardName: Route]
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
        routes: [
            .HomeView: Route(pattern: "^$", parents: [
                .RestaurantsView: [.HomeView],
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
                ]),
            .OrdersView: Route(pattern: "^orders$", parents: [
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
                ]),
            .SettingsView: Route(pattern: "^settings$", parents: [
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
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
        routes: [
            .HomeView: Route(pattern: "^$", parents: [
                .RestaurantsView: [.HomeView],
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
                ]),
            .OrdersView: Route(pattern: "^orders$", parents: [
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
                ]),
            .SettingsView: Route(pattern: "^settings$", parents: [
                .TabsView: [.RestaurantsView, .OrdersView, .SettingsView]
                ])
        ]
    )
)


