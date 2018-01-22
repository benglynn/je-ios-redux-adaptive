import Foundation

func presentMenu(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.last?.screen != Screen.Menu else {
        return currentSlice
    }
    return CoreStateSlice(
        isAdapted: currentSlice.isAdapted,
        path: currentSlice.path,
        screensInSession: currentSlice.screensInSession,
        reducers: currentSlice.reducers,
        screenFamilyStack: currentSlice.screenFamilyStack + [ScreenFamily(screen: .Menu, children: nil)],
        routes: currentSlice.routes
    )
}

func dismissMenu(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    return currentSlice
}

func activateMenuAdaptation(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    
    var adaptedReducers = stateSlice.reducers
    adaptedReducers[.presentMenu] = .presentMenuReducer
    adaptedReducers[.dismissMenu] = .dismissMenuReducer
    
    let adaptedRoutes: [Route] = [(
        pathPattern: .HomePath,
        screens: [
            ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
            ScreenFamily(screen: .MenuHome, children: nil),
            ]
        ),(
            pathPattern: .AreaPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ]
        ),(
            pathPattern: .OrdersPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ScreenFamily(screen: .Orders, children: nil),
                ]
        ),(
            pathPattern: .SettingsPath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ScreenFamily(screen: .Settings, children: nil),
                ]
        )
    ]
    
    return CoreStateSlice(
        isAdapted: stateSlice.isAdapted,
        path: stateSlice.path,
        screensInSession: stateSlice.screensInSession,
        reducers: adaptedReducers,
        screenFamilyStack: stateSlice.screenFamilyStack,
        routes: adaptedRoutes
    )
}
