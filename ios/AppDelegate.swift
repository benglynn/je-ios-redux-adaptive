import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let bag = DisposeBag()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fetchAdaptations()
        }
        return true
    }
    
    func fetchAdaptations() {
        let response = Observable.from([AdaptationService.url])
            .map { urlString -> URL in
                return URL(string: urlString)!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { (request) -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1, scope: .whileConnected)
        
        response
            .subscribe(onNext: { response, data in
                // TODO handle error responses
                let decoder = JSONDecoder()
                let serviceResponse = try! decoder.decode(AdaptationServiceResponse.self, from: data) // TODO handle failure
                print("Received \(serviceResponse.actions.count) actions")
                serviceResponse.actions.forEach({ print("\($0.type) is \($0.active ? "active" : "inactive")") })
            })
            .disposed(by: bag)
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            let mask = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
            $0.present(mask, animated: false, completion: nil)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            $0.dismiss(animated: false, completion: nil)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func withTopmost(_ viewController: UIViewController, _ callback: (_ viewController: UIViewController)->Void) {
        let presented = viewController.presentedViewController
        if(presented != nil) {
            withTopmost(presented!, callback)
        } else {
            callback(viewController)
        }
    }


}

