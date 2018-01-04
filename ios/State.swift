import Foundation

struct State {
    
    struct Config {
        let isAdapted: Bool
        let routes: [ViewName: Route]
        let parents: [ViewName: ParentView]
    }
    
    let config: Config
    
}

let initialState = State(
    config: State.Config(
        isAdapted: false,
        routes: [
            .HomeView: Route(pattern: "^$", parent: .RestaurantsView),
            .OrdersView: Route(pattern: "^orders$", parent: .TabsView),
            .SettingsView: Route(pattern: "^settings$", parent: .TabsView)
        ],
        parents: [
            .TabsView: ParentView(children: [.RestaurantsView, .OrdersView, .SettingsView]),
            .RestaurantsView: ParentView(children: [.HomeView])
        ]
    )
)

// TODO: this is a temporary struct, remove it once action/reducers are in place
let adaptedState = State(
    config: State.Config(
        isAdapted: true,
        routes: [
            .HomeView: Route(pattern: "^$", parent: .RestaurantsView),
            .OrdersView: Route(pattern: "^orders$", parent: .TabsView),
            .SettingsView: Route(pattern: "^settings$", parent: .TabsView)
        ],
        parents: [
            .TabsView: ParentView(children: [.RestaurantsView, .OrdersView, .SettingsView]),
            .RestaurantsView: ParentView(children: [.HomeView])
        ]
    )
)


