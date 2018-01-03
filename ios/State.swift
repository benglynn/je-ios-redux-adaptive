import Foundation

struct State {
    
    struct Config {
        let routes: [ViewName: Route]
        let parents: [ViewName: ParentView]
    }
    
    let config: Config
    
}

let initialState = State(
    config: State.Config(
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

