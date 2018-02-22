import Foundation
import RxSwift
import RxCocoa

protocol Getable: Requestable {}

extension Getable {
    func getResponse() -> Observable<(response: HTTPURLResponse, data: Data)> {
        let urlRequest: Observable<URLRequest> = Observable.create() { observer in
            let url = URL(string: self.url)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            observer.onNext(request)
            observer.onCompleted()
            return Disposables.create()
        }
        
        return urlRequest.flatMap() { request in
            return URLSession.shared.rx.response(request: request)
        }
    }
}
