import Foundation

struct State {
    
    struct Core {
        let path: String
    }
    
    struct Config {
        let isAdapted: Bool
        let routes: [ViewName: Route]
        let parents: [ViewName: [ViewName]]
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
            .HomeView: Route(pattern: "^$", parent: .RestaurantsView),
            .OrdersView: Route(pattern: "^orders$", parent: .TabsView),
            .SettingsView: Route(pattern: "^settings$", parent: .TabsView)
        ],
        parents: [
            .TabsView: [.RestaurantsView, .OrdersView, .SettingsView],
            .RestaurantsView: [.HomeView]
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
            .HomeView: Route(pattern: "^$", parent: .RestaurantsView),
            .OrdersView: Route(pattern: "^orders$", parent: .TabsView),
            .SettingsView: Route(pattern: "^settings$", parent: .TabsView)
        ],
        parents: [
            .TabsView: [.RestaurantsView, .OrdersView, .SettingsView],
            .RestaurantsView: [.HomeView]
        ]
    )
)


