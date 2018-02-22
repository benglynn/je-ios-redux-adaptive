import Foundation
import RxSwift
import RxCocoa

struct AdaptationService: Getable {
    let url = "https://state-service.appspot.com/assets/actions.json"
    let minLatency: Float = 0.0
    let defaultResponse = AdaptationServiceResponse(actions: [])
    
    func get() -> Observable<AdaptationServiceResponse> {
        return self.getResponse().map() { response, data -> AdaptationServiceResponse in
            let decoder = JSONDecoder()
            let serviceResponse = try! decoder.decode(AdaptationServiceResponse.self, from: data)
            return serviceResponse
        }
    }
}
