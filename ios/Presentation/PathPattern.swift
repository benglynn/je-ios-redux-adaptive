import Foundation

enum PathPattern: String {
    case HomePath = "^$"
    case OrdersPath = "^orders$"
    case SettingsPath = "^settings$"
    case AreaPath = "^[a-z]{1,2}[0-9][0-9a-z]?[0-9][a-z]{2}$" // postcode
}

typealias Route = (pathPattern: PathPattern, screens: [ScreenFamily])
