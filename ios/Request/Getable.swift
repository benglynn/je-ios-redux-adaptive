import Foundation
import RxSwift
import RxCocoa

protocol Getable: Requestable {
    func get() -> Observable<ResponseType>
}

extension Getable {
    
    func getResponse() -> Observable<(response: HTTPURLResponse, data: Data)> {
        let globalShchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        return Observable.create() { observer in
            var urlComponents = URLComponents(string: self.baseUrl)!
            self.prepare(&urlComponents)
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            self.prepare(&request)
            observer.onNext(request)
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribeOn(globalShchedular)
        .flatMap() { request in
            return URLSession.shared.rx.response(request: request)
        }
        .do(onNext: { response, data in
            if 400 ..< 500 ~= response.statusCode {
                print("Request client error")
                throw RequestableError.clientError
            } else if response.statusCode >= 500 {
                print("Request server error")
                throw RequestableError.serverError
            }
        })
    }
}
