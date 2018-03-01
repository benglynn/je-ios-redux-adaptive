import Foundation
import RxSwift

struct AdaptationService: Getable {
    let baseUrl = "https://state-service.appspot.com/assets/actions.json"
//    let baseUrl = "https://us-central1-state-service.cloudfunctions.net/actions"
    let queryItems: [URLQueryItem] = []
    let defaultResponse = AdaptationServiceResponse(actions: [])
    typealias ResponseType = AdaptationServiceResponse
    
    func get() -> Observable<AdaptationServiceResponse> {
        return self.getResponse()
            .map() { response, data -> AdaptationServiceResponse in
                let decoder = JSONDecoder()
                do {
                    let serviceResponse = try decoder.decode(AdaptationServiceResponse.self, from: data)
                    return serviceResponse
                } catch {
                    print("Error parsing adaptation service response: \(error.localizedDescription)")
                    throw RequestableError.parseError
                }
            }
            .catchError() { error in
                print("Failed to activate adaptations")
                return Observable.of(self.defaultResponse)
            }
    }
}
