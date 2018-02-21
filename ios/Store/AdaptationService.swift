import Foundation
import RxSwift
import RxCocoa

struct AdaptationService {
    
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    private let url = "https://us-central1-state-service.cloudfunctions.net/actions"
    
    func asObservable(fake: Bool = false) -> Observable<AdaptationServiceResponse> {
        if fake == true {
            let fakeActions: [AdaptationServiceAction] = [
                // Add fake actions below
                "activateMenuAdaptationAction"
            ].map { AdaptationServiceAction(type: $0, active: true, id: "x") }
            return Observable.from([AdaptationServiceResponse(actions: fakeActions)])
        }
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
                // TODO: 1 retry, but timeout after 3 seconds
                let decoder = JSONDecoder()
                // TODO handle parse failure
                let serviceResponse = try! decoder.decode(AdaptationServiceResponse.self, from: data)
                return serviceResponse
            }
            .share(replay: 1, scope: .whileConnected)
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
