import Foundation

func activateMenuAdaptationReducer(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    var adaptedReducers = currentSlice.reducers
    adaptedReducers[.presentMenu] = .presentMenuReducer
    let adaptedRoutes: [Route] = [
        Route(
            pathPattern: .HomePath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ],
            effect: nil
        ),
        Route(
            pathPattern: .AreaPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ],
            effect: .searchEffect
        ),
        Route(
            pathPattern: .OrdersPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ScreenFamily(screen: .MenuOrders, children: nil),
                ],
            effect: nil
        ),
        Route(
            pathPattern: .SettingsPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ScreenFamily(screen: .MenuSettings, children: nil),
                ],
            effect: nil
        )
    ]
    return currentSlice.cloneWith(reducers: adaptedReducers, routes: adaptedRoutes)
}
