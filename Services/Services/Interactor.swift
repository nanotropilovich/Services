import Foundation
protocol ViewInterface: AnyObject {
    func showServices(_ services: [Service])
    func showError(_ error: Error)
}
protocol InteractorInput {
    func fetchServices()
}
protocol InteractorOutput: AnyObject {
    func servicesFetched(_ services: [Service])
    func servicesFetchFailed(_ error: Error)
}
class Interactor: InteractorInput {
    weak var presenter: InteractorOutput?
    func fetchServices() {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: urlString) else {
            self.presenter?.servicesFetchFailed(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                self.presenter?.servicesFetchFailed(error)
                return
            }
            guard let data = data else {
                self.presenter?.servicesFetchFailed(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(ResponseData.self, from: data)
                self.presenter?.servicesFetched(responseData.body.services)
            } catch {
                self.presenter?.servicesFetchFailed(error)
            }
        }
        task.resume()
    }
}

