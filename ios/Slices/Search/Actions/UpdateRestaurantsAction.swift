import Foundation

struct UpdateRestaurantsAction: Actionable {
    let type = Action.updateRestaurantsAction
    let restuarnts: [Restaurant]?
}
