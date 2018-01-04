import Foundation
import RxSwift
import RxCocoa

class AdaptationService {
    
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    
    private let url = "https://us-central1-state-service.cloudfunctions.net/actions"
    
    var actions$: Observable<AdaptationServiceResponse> {
        get {
            return Observable.from([url])
                // .delay(3.5, scheduler: globalScheduler)
                .map { urlString -> URL in
                    return URL(string: urlString)!
                }
                .map { url -> URLRequest in
                    return URLRequest(url: url)
                }
                .flatMap { (request) -> Observable<(response: HTTPURLResponse, data: Data)> in
                    return URLSession.shared.rx.response(request: request)
                }
                .map { response, data -> AdaptationServiceResponse in
                    // TODO handle error responses
                    let decoder = JSONDecoder()
                    let serviceResponse = try! decoder.decode(AdaptationServiceResponse.self, from: data) // TODO handle failure
                    return serviceResponse
                }
                .share(replay: 1, scope: .whileConnected)
        }
    }
}

struct AdaptationServiceAction: Codable {
    let type: String
    let active: Bool
    let id: String
}

struct AdaptationServiceResponse: Codable {
    let actions: [AdaptationServiceAction]
}
