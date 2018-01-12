import Foundation

enum PathPattern: String {
    case HomePath = "^$"
    case OrdersPath = "^orders$"
    case SettingsPath = "^settings$"
    case AreaPath = "^bs14dj$" // TODO: postcode regex
}

typealias Route = (pathPattern: PathPattern, screens: [ScreenFamily])
