import Foundation
import RxSwift

struct SearchService: Getable {
    typealias ResponseType = [Restaurant]
    let baseUrl = "https://public.je-apis.com/restaurants/v3"
    let queryItems = [
        URLQueryItem(name: "c", value: ""),
        URLQueryItem(name: "name", value: "")
    ]
    let defaultResponse: SearchServiceResponse? = nil
    let q: String
    
    init(q: String) {
        self.q = q
    }
    
    func prepare(_ urlComponents: inout URLComponents) {
        urlComponents.queryItems = queryItems + [URLQueryItem(name: "q", value: q)]
    }
    
    func prepare(_ request: inout URLRequest) {
        request.setValue("Basic YnJpc3RvbC11bml2ZXJzaXR5OkBRM3dlUFVWRGRLaGZzdHNURDRHRnZmVGRidEJtQE1M", forHTTPHeaderField: "Authorization")
        request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
        request.setValue("en-US,en;q=0.8", forHTTPHeaderField: "Accept-Language")
        request.setValue("uk", forHTTPHeaderField: "Accept-Tenant")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func get() -> Observable<[Restaurant]> {
        return self.getResponse()
            .map() { response, data -> [Restaurant] in
                let decoder = JSONDecoder()
                let serviceResponse = try! decoder.decode(SearchServiceResponse.self, from: data)
                let restaurants: [Restaurant] = serviceResponse.OpenRestaurants.map { serviceRestaurant in
                    Restaurant.init(serviceRestaurant, isOpen: true)
                } + serviceResponse.ClosedRestaurants.map { serviceRestaurant in
                    Restaurant.init(serviceRestaurant, isOpen: false)
                }
            return restaurants
        }
    }
}

