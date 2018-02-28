import UIKit
import RxSwift

func searchEffect(store: Store, currentState: State) {
    let postcode = currentState.core.path
    let searchService = SearchService(q: postcode) // TODO: from injector
    _ = searchService.get()
        .subscribe(onNext: { response in
            print("Response has \(response.count) reults")
            store.dispatch(UpdatePostcodeAction(postcode: postcode))
            store.dispatch(UpdateRestaurantsAction(restuarnts: response))
        })
}

