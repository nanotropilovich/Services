import Foundation
import SafariServices
import UIKit
protocol RouterInput {
    func navigateToService(_ url: String)
}
class Router: RouterInput {
    weak var viewController: UIViewController?

    func navigateToService(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let safariViewController = SFSafariViewController(url: url)
            viewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
}

