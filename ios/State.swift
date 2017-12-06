import Foundation

struct State {
    
    struct Route {
        let match: String
        let viewName: ViewName
    }
    
    struct Core {
        let url: String
        let routes: [Route]
    }
    
    let core: Core
}

let initialState = State(
    core: State.Core(
        url: "",
        routes: [
            State.Route(match: "^$", viewName: .HomeView)
        ])
)
