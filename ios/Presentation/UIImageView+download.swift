import UIKit

let downloadedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    func download(fromLocation: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: fromLocation) else { return }
        let key = fromLocation as NSString
        if let cached = downloadedImages.object(forKey: key) {
            self.image = cached
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                downloadedImages.setObject(image, forKey: key)
                DispatchQueue.main.async() {
                    self.image = image
                }
            }.resume()
        }
    }
}
