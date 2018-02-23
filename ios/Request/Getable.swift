import Foundation
import RxSwift
import RxCocoa

protocol Getable: Requestable {}

extension Getable {
    func getResponse() -> Observable<(response: HTTPURLResponse, data: Data)> {
        let globalShchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        return Observable.create() { observer in
            let url = URL(string: self.url)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            observer.onNext(request)
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribeOn(globalShchedular)
        .flatMap() { request in
            return URLSession.shared.rx.response(request: request)
        }
    }
}
